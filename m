Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D9458C81A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 14:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242653AbiHHMFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 08:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242527AbiHHMFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 08:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4DB2263D
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 05:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659960331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fu+EGKvg0tvo2gbBuEatwKbSy6SV8sz3wHepu6Tfd8E=;
        b=MCqipCFAMClbMsgkMFT/oCOhBxx3D7GvbqSv17mVRFPSpgjMYPopekUxa1hfHtia+Zgun6
        jjJy+2kqLD7rOLCJi3caHVsy2e8fF78Oh9DF8l+7LxXqZT53w9HAxUNUhM/Li0jHuCPt+A
        maYLeHorPD6KyKTo5kj59tX2DH/F/C0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-8Li_jNhjPEO5bh_ibEG71g-1; Mon, 08 Aug 2022 08:05:30 -0400
X-MC-Unique: 8Li_jNhjPEO5bh_ibEG71g-1
Received: by mail-ed1-f70.google.com with SMTP id n8-20020a05640205c800b00434fb0c150cso5495249edx.19
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 05:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fu+EGKvg0tvo2gbBuEatwKbSy6SV8sz3wHepu6Tfd8E=;
        b=Qwx/av0NSR0SxubIEL6ZXcThpF1nEyBgNOwHb6OqmmcjOCB/WCPQ51kfBkZNrhmGWD
         DaqqlmH7qXUFOv7NcqKDV1rtk/4rlzoePDuPvAOjnGqKHuqBDignJHcgWzOMMbjyzpi9
         12Lrz789oCSLa4Q8LewqTWpI3rYiJ4pbJG49WjF4VoB4MpjegsPToHDqeXbE2BgjLqMl
         Y0g5ze5yL/9/dRjtZDtAI1FoXl5O0wmj8vB8k7PsGika6wy/E5anJHozyNZzh3vCWCXM
         tkTBnp8shFI0wYquPvM1A8b5wN9YY69aHg5Z9k0TqVM8wugiwCzcwxodsrx0mb/q4W5Y
         0eig==
X-Gm-Message-State: ACgBeo1QDaX76AbT7GCx3WK+Z6ywgfspBmtlChP+13UVqHHtcUd8A7Pa
        gyzgL9JVWiaKdhmuB1EiOGFt4D4FxlP67gKOx/MEp8MusCAKRpwsYdSPTx8/Gh7tVMA/0NdX5QJ
        hPoayN1fSANbMryY+Y1/0qL1q4BIzI4Viq+wWoa7u
X-Received: by 2002:a17:907:2d94:b0:730:cad8:fe80 with SMTP id gt20-20020a1709072d9400b00730cad8fe80mr13670216ejc.232.1659960329671;
        Mon, 08 Aug 2022 05:05:29 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4CLRlV/9x9dD2aK9/HEUTGST8O923oVKubnUWsl1DUA3H8QK1c8I0bxjvCqukDPrkG7iy+Hc20DOZSW/oz9XA=
X-Received: by 2002:a17:907:2d94:b0:730:cad8:fe80 with SMTP id
 gt20-20020a1709072d9400b00730cad8fe80mr13670194ejc.232.1659960329404; Mon, 08
 Aug 2022 05:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220804003323.1441376-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Yu1z0KcU5C2AJO6S@fedora> <3075adc7-e02e-fcd4-44ef-c4228293f460@linux.intel.com>
In-Reply-To: <3075adc7-e02e-fcd4-44ef-c4228293f460@linux.intel.com>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Mon, 8 Aug 2022 09:05:18 -0300
Message-ID: <CAAq0SUmY7VvAFVmM--y+QMsjHaUMo27Rn3rO9hcXQsBFGmRwJg@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] x86/tdx: Add TDX Guest attestation interface driver
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 5, 2022 at 6:35 PM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
>
>
> On 8/5/22 12:47 PM, Wander Lairson Costa wrote:
> > On Wed, Aug 03, 2022 at 05:33:22PM -0700, Kuppuswamy Sathyanarayanan wrote:
> >> +/**
> >> + * struct tdx_report_req: Get TDREPORT using REPORTDATA as input.
> >> + *
> >> + * @subtype        : Subtype of TDREPORT (fixed as 0 by TDX Module
> >> + *                   specification, but added a parameter to handle
> >> + *                   future extension).
> >> + * @reportdata     : User-defined REPORTDATA to be included into
> >> + *                   TDREPORT. Typically it can be some nonce
> >> + *                   provided by attestation service, so the
> >> + *                   generated TDREPORT can be uniquely verified.
> >> + * @rpd_len        : Length of the REPORTDATA (fixed as 64 bytes by
> >> + *                   the TDX Module specification, but parameter is
> >> + *                   added to handle future extension).
> >> + * @tdreport       : TDREPORT output from TDCALL[TDG.MR.REPORT].
> >> + * @tdr_len        : Length of the TDREPORT (fixed as 1024 bytes by
> >> + *                   the TDX Module specification, but a parameter
> >> + *                   is added to accommodate future extension).
> >> + *
> >> + * Used in TDX_CMD_GET_REPORT IOCTL request.
> >> + */
> >> +struct tdx_report_req {
> >> +    __u8  subtype;
> >> +    __u64 reportdata;
> >> +    __u32 rpd_len;
> >> +    __u64 tdreport;
> >> +    __u32 tdr_len;
> >> +};
> >
> > Any reason why reportdata and tdreport aren't "void *"?
>
> It is the recommended way to pass the pointers.
>
> https://docs.kernel.org/driver-api/ioctl.html
>

Ah, right. In this case, we should use the u64_to_user_ptr() function
for pointer conversion as recommended.

