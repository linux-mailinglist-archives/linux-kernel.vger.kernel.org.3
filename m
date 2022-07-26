Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22E9581BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 23:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbiGZVXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 17:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGZVXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 17:23:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20692FFE1;
        Tue, 26 Jul 2022 14:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658870609; x=1690406609;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=I7AiIy87J0V+7Y2eEso3nT4BJc0sYMCa8DkpGScJ4AQ=;
  b=Kx6YwH4j4zpXYnOOR2BFz5t6io54L8Yh8j8vzMw6DWNZ8ZIUsUVVb0Nh
   0+WNfrAHkSKgveYZmBBoV/zWihn7eUxIE0SQ2XijW08rG+rB2LgjtDr90
   DpzP6BIrtlnUqJpChWU6aTVpYZsHeMlHcsZmHUU08GY+tSCdBMjK5ZN15
   YDpPosTYc30qfGgqcOwF6qfExtj0/PIGJ3r0MFUaNm05bmkJuTur8sVid
   cdkAWwBPe8S6BkKwLZ7kR2HD+IHth2z/ozc5nk4J3x1XnpsATilwL2biY
   /g/l2vdJDNDocc0vyupOs3TVw/M+J57JWDpNicZ4A/7HJAS26s3UKbxyk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="352057375"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="352057375"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 14:23:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="575669072"
Received: from rgevard-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.32.51])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 14:23:26 -0700
Message-ID: <4efdfef972073eb927150c528487d22373bef4d3.camel@intel.com>
Subject: Re: [PATCH] [v2] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
From:   Kai Huang <kai.huang@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, dave@sr71.net
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Haitao Huang <haitao.huang@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 27 Jul 2022 09:23:24 +1200
In-Reply-To: <2950d520-c49e-e4d9-90ee-26fe1ec4fb02@intel.com>
References: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
         <ab467244dd03b5f94bafe9068b1c02790033c18c.camel@intel.com>
         <2950d520-c49e-e4d9-90ee-26fe1ec4fb02@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-07-26 at 08:36 -0700, Dave Hansen wrote:
> On 7/22/22 06:26, Kai Huang wrote:
> > Did a quick look at the spec.  It appears ENCLU[EDECCSSA] should be use=
d
> > together with AEX-notify.  So besides advertising the new
> > SGX_ATTR_ASYNC_EXIT_NOTIFY bit to the KVM guest, I think we should also
> > advertise the ENCLU[EDECCSSA] support in guest's CPUID, like below (unt=
ested)?
>=20
> Kai, would you care to send a new version of this with a proper SoB and
> changelog integrating what you've learned since posting it?  It can be
> merged along with AEX notify itself.

Sure will do today.

--=20
Thanks,
-Kai


