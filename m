Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 547874DB64D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350308AbiCPQjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238933AbiCPQjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C4C321B5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647448668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jHEVJaqCCqwyj0GRbWELjpndY1ginS3nDRc87SV2N9M=;
        b=eCTUKZyAAE6n7Add0xs4JiDeroGa9cEOJXi6iLPuur88FDl42D6tgoXfZbEG+jD8//Iksd
        /KCze3+mI45MNu5aygXkvKd17nFTs7ME8kPH6H+339A9s5CLLuA/aoUnyx2KBmlImJesWD
        A4aYdTeuMfXtLibvFy7Z48kf4oeHNGs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-gMebxpjJMwu5jLUdVwls5A-1; Wed, 16 Mar 2022 12:37:47 -0400
X-MC-Unique: gMebxpjJMwu5jLUdVwls5A-1
Received: by mail-lf1-f69.google.com with SMTP id y23-20020a0565123f1700b00448221b91e5so928852lfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:37:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jHEVJaqCCqwyj0GRbWELjpndY1ginS3nDRc87SV2N9M=;
        b=vgwSEwMF0eWVsix+4MkiOnHSQ+B2t0Oljy4KRI0fBH0CQ/wKyZW8F1h4XssKKEM5iY
         6evJZk12Sio+WSFIKgfobsUvvUYkmliYKEPEC7zmpnHFRv3lhSX4T1NUsMjBmcfyaYXy
         jsScY0Zv9FCPqsJT5lnwzgmJ8dhE2UMBtIoPYPGs+RDVxDBcQa0JoyMIEy2Ji4xw9JDB
         LFOocIJ1773yQjGVSOCQoEVTyrFr038fGXA4OCcbXiMeaKoAZFwy903g3PkszVpOhAu1
         gvRMxLW739awKtv7ihyxVeesTGyo4/jlbWwEXs2yABZdRwzjekLhHVmX/FJl0DIZJDPn
         6fVA==
X-Gm-Message-State: AOAM530i74aspmcO6b+EXDsIc9UvIxSVI2XFhcOLkQapp77KBvpEov8w
        b2WYXM4dxf16e+1frE/IuJtnj1/ymHajMPD/5nDinyUuXZwIYuIWI0KeSjOnQQGgDM39/7/WlUE
        RxNBnVx03iNHAgJfbNTMJIWV6sY8gQ/stgOoucPPe
X-Received: by 2002:a19:dc50:0:b0:448:816d:2dd8 with SMTP id f16-20020a19dc50000000b00448816d2dd8mr264665lfj.1.1647448665993;
        Wed, 16 Mar 2022 09:37:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxON6uSO8M4DAucsY5caNVYsjogOOiaQfUlGsrZZJMxA7xyBy+eOgl0Ss88e2+gcQ9eHOcV+2mXTG1b7tgAWNo=
X-Received: by 2002:a19:dc50:0:b0:448:816d:2dd8 with SMTP id
 f16-20020a19dc50000000b00448816d2dd8mr264654lfj.1.1647448665781; Wed, 16 Mar
 2022 09:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220316143646.13301-1-wander@redhat.com> <YjIMn/cBf7STIxBU@smile.fi.intel.com>
In-Reply-To: <YjIMn/cBf7STIxBU@smile.fi.intel.com>
From:   Wander Costa <wcosta@redhat.com>
Date:   Wed, 16 Mar 2022 13:37:34 -0300
Message-ID: <CAAq0SUkZK_FkCk7k--t6yAh8LcEdMajPetVLGAnSy4VPEwy09g@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] tty/8250: Use fifo in 8250 console driver
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        =?UTF-8?Q?Andr=C3=A9_Goddard_Rosa?= <andre.goddard@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Jon Hunter <jonathanh@nvidia.com>, phil@raspberrypi.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 1:15 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Mar 16, 2022 at 11:36:39AM -0300, Wander Lairson Costa wrote:
> > This version fixes the bugs reported in version v3. The first patch
> > is the same patch of v3 as is. The following commits fix the issues in the
> > original patch. For details, please check the commit log of each patch.
> >
> > I tested these patches in the following systems:
> >
> > * IBM X3550 M3
> > * HP ProLiant DL380 Gen9
> > * HP ProLiant BL480c G1
> > * Dell PowerEdge R910
> > * Cisco UCSC-C220-M3S
> >
> > I cc everybody that reported problems with the previous version of this
> > patch so they can retest and confirm their systems work flawlessly.
>
> I have got this only message and I don't see any good changelog what has
> been done between v3 and v4.
>

Weird, the patches were sent [1,2,3,4,5] and reached out my inbox.

[1] https://lore.kernel.org/all/20220316143646.13301-2-wander@redhat.com/
[2] https://lore.kernel.org/all/20220316143646.13301-3-wander@redhat.com/
[3] https://lore.kernel.org/all/20220316143646.13301-4-wander@redhat.com/
[4] https://lore.kernel.org/all/20220316143646.13301-5-wander@redhat.com/
[5] https://lore.kernel.org/all/20220316143646.13301-6-wander@redhat.com/

[snip]

