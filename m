Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2748E4BE57D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356730AbiBULsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:48:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242753AbiBULs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:48:28 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D1B1EEE6;
        Mon, 21 Feb 2022 03:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645444085; x=1676980085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d2nxSyxlFXj9Y46HQxQTGJPE6uNfiwCTcyQito04juU=;
  b=QUP9c7FgSwFWB3m3foNATrhxlm4uPApRpjjSwzLS+Vu9ixzbnVkW616j
   GLAz7Y1f5QmRNECLSAg6E7QOhQXns0Jgg+BsRDVVbbSSWH/9f+5qiRYY5
   iaEd3O0HgVQNjYZO5b2Itveq33xbTN2vRt1xxraWRdPbb9RuAm2e1pC71
   gzlYpgzoWlTv2jLt2RgbQ78obi/9YRIwmafzQLriBod8Z0Zsh6p9GVNXo
   sVWjvynrV3XqMPWtn70EaW//pX1m5XjzMlJn5TSuIG+pSoaqWG4ak6Sjn
   RMHPrSDXjKDYWTbiGUs98Svmo4PeDG329E8ZTdab1u4avDLr8ALuXz2r4
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="231463399"
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="231463399"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 03:48:05 -0800
X-IronPort-AV: E=Sophos;i="5.88,385,1635231600"; 
   d="scan'208";a="547305643"
Received: from silpixa00400314.ir.intel.com (HELO silpixa00400314) ([10.237.222.76])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 03:48:02 -0800
Date:   Mon, 21 Feb 2022 11:47:55 +0000
From:   Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To:     Kyle Sanderson <kyle.leet@gmail.com>, herbert@gondor.apana.org.au
Cc:     Dave Chinner <david@fromorbit.com>, qat-linux@intel.com,
        Linux-Kernal <linux-kernel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Intel QAT on A2SDi-8C-HLN4F causes massive data corruption with
 dm-crypt + xfs
Message-ID: <YhN76/ONC9qgIKQc@silpixa00400314>
References: <CACsaVZ+mt3CfdXV0_yJh7d50tRcGcRZ12j3n6-hoX2cz3+njsg@mail.gmail.com>
 <20220219210354.GF59715@dread.disaster.area>
 <CACsaVZ+LZUebtsGuiKhNV_No8fNLTv5kJywFKOigieB1cZcKUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsaVZ+LZUebtsGuiKhNV_No8fNLTv5kJywFKOigieB1cZcKUw@mail.gmail.com>
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 -
 Collinstown Industrial Park, Leixlip, County Kildare - Ireland
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kyle,

The issue is that the implementations of aead and skcipher in the QAT
driver are not properly supporting requests with the
CRYPTO_TFM_REQ_MAY_BACKLOG flag set.
If the HW queue is full, the driver returns -EBUSY [1] but does not
enqueues the request as dm-crypt expects [2]. Dm-crypt ends up waiting
indefinitely for a completion to a request that was never submitted,
therefore the stall.
This is not related to QATE-7495 'An incorrectly formatted request to
QAT can hang the entire QAT endpoint' [3], which occurs when a malformed
request is sent to the device.

I'm working at patch that resolves this problem. In the meanwhile a
workaround is to blacklist the qat_c3xxx.ko driver.

Regarding avoiding this issue on stable kernels. The usage of QAT with
dm-crypt was already disabled in kernel 5.10 for a different issue
(the driver allocates memory in the datapath).
The following patches implement the change:
    7bcb2c99f8ed crypto: algapi - use common mechanism for inheriting flags
    2eb27c11937e crypto: algapi - add NEED_FALLBACK to INHERITED_FLAGS
    fbb6cda44190 crypto: algapi - introduce the flag CRYPTO_ALG_ALLOCATES_MEMORY
    b8aa7dc5c753 crypto: drivers - set the flag CRYPTO_ALG_ALLOCATES_MEMORY
    cd74693870fb dm crypt: don't use drivers that have CRYPTO_ALG_ALLOCATES_MEMORY
An option would be to send the patches above to stable, another is to wait
for a patch that fixes the problems in the QAT driver and send that to
stable.
@Herbert, what is the preferred approach here?

Thanks,

[1] https://elixir.bootlin.com/linux/latest/source/drivers/crypto/qat/qat_common/qat_algs.c#L1022
[2] https://elixir.bootlin.com/linux/latest/source/drivers/md/dm-crypt.c#L1584
[3] https://01.org/sites/default/files/downloads//336211qatsoftwareforlinux-rn-hwversion1.7021.pdf - page 25

-- 
Giovanni


On Sat, Feb 19, 2022 at 03:00:51PM -0800, Kyle Sanderson wrote:
> hi Dave,
> 
> > This really sounds like broken hardware, not a kernel problem.
> 
> It is indeed a hardware issue, specifically the intel qat crypto
> driver that's in-tree - the hardware is fine (see below). The IQAT
> eratta documentation states that if a request is not submitted
> properly it can stall the entire device. The remediation guidance from
> 2020 was "don't do that" and "don't allow unprivileged users access to
> the device". The in-tree driver is not implemented properly either for
> this SoC or board - I'm thinking it's related to QATE-7495.
> 
> https://01.org/sites/default/files/downloads//336211qatsoftwareforlinux-rn-hwversion1.7021.pdf
> 
> > This implies a dmcrypt level problem - XFS can't make progress is dmcrypt is not completing IOs.
> 
> That's the weird part about it. Some bio's are completing, others are
> completely dropped, with some stalling forever. I had to use
> xfs_repair to get the volumes operational again. I lost a good deal of
> files and had to recover from backup after toggling the device back on
> on a production system (silly, I know).
> 
> > Where are the XFS corruption reports that the subject implies is occurring?
> 
> I think you're right, it's dm-crypt that's broken here, with
> ultimately the crypto driver causing this corruption. XFS being the
> edge to the end-user is taking the brunt of it. There's reports going
> back to late 2017 of significant issues with this mainlined stable
> driver.
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1522962
> https://serverfault.com/questions/1010108/luks-hangs-on-centos-running-on-atom-c3758-cpu
> https://www.phoronix.com/forums/forum/software/distributions/1172231-fedora-33-s-enterprise-linux-next-effort-approved-testbed-for-raising-cpu-requirements-etc?p=1174560#post1174560
> 
> Any guidance would be appreciated.
> Kyle.
> On Sat, Feb 19, 2022 at 1:03 PM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Fri, Feb 18, 2022 at 09:02:28PM -0800, Kyle Sanderson wrote:
> > > A2SDi-8C-HLN4F has IQAT enabled by default, when this device is
> > > attempted to be used by xfs (through dm-crypt) the entire kernel
> > > thread stalls forever. Multiple users have hit this over the years
> > > (through sporadic reporting) - I ended up trying ZFS and encryption
> > > wasn't an issue there at all because I guess they don't use this
> > > device. Returning to sanity (xfs), I was able to provision a dm-crypt
> > > volume no problem on the disk, however when running mkfs.xfs on the
> > > volume is what triggers the cascading failure (each request kills a
> > > kthread).
> >
> > Can you provide the full stack traces for these errors so we can see
> > exactly what this cascading failure looks like, please? In reality,
> > the stall messages some time after this are not interesting - it's
> > the first errors that cause the stall that need to be investigated.
> >
> > A good idea would be to provide the full storage stack decription
> > and hardware in use, as per:
> >
> > https://xfs.org/index.php/XFS_FAQ#Q:_What_information_should_I_include_when_reporting_a_problem.3F
> >
> > > Disabling IQAT on the south bridge results in a working
> > > system, however this is not the default configuration for the
> > > distribution of choice (Ubuntu 20.04.3 LTS), nor the motherboard. I'm
> > > convinced this never worked properly based on the lack of popularity
> > > for kernel encryption (crypto), and the embedded nature that
> > > SuperMicro has integrated this device in collaboration with intel as
> > > it looks like the primary usage is through external accelerator cards.
> >
> > This really sounds like broken hardware, not a kernel problem.
> >
> > > Kernels tried were from RHEL8 over a year ago, and this impacts the
> > > entirety of the 5.4 series on Ubuntu.
> > > Please CC me on replies as I'm not subscribed to all lists. CPU is C3758.
> >
> > [snip stalled kcryptd worker threads]
> >
> > This implies a dmcrypt level problem - XFS can't make progress is
> > dmcrypt is not completing IOs.
> >
> > Where are the XFS corruption reports that the subject implies is
> > occurring?
> >
> > Cheers,
> >
> > Dave.
> > --
> > Dave Chinner
> > david@fromorbit.com
