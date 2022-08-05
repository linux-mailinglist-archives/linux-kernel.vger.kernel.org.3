Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D942F58B081
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 21:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237587AbiHETrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 15:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiHETru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 15:47:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57112167DE
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 12:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659728859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nx9G9y1EjYBhqiHWUAKcBjnWHxsMiMBJ2QDIpjyrXWI=;
        b=C0Yb27TFSMUOPLtwzPXXw7oKsI8QfUqLKKfDEJoIgShIG9JdvabzOrhCuEIOHsbkV1Cz6H
        flkykllaObgx+Z4EZnu9eoHu8V0I9FsWpcsRMGPxV+V/eWijpKuuK0BSap/eTB1um/T1iV
        XCywjjlc86WCGkM/L0bA33JhRyNzdWI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-158-tyOXrZumOb-4kzFDATKU-Q-1; Fri, 05 Aug 2022 15:47:37 -0400
X-MC-Unique: tyOXrZumOb-4kzFDATKU-Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F40A31C06EEC;
        Fri,  5 Aug 2022 19:47:33 +0000 (UTC)
Received: from fedora (unknown [10.22.33.164])
        by smtp.corp.redhat.com (Postfix) with SMTP id CBC3A2024CB6;
        Fri,  5 Aug 2022 19:47:29 +0000 (UTC)
Date:   Fri, 5 Aug 2022 16:47:28 -0300
From:   Wander Lairson Costa <wander@redhat.com>
To:     Kuppuswamy Sathyanarayanan 
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
Subject: Re: [PATCH v10 1/2] x86/tdx: Add TDX Guest attestation interface
 driver
Message-ID: <Yu1z0KcU5C2AJO6S@fedora>
References: <20220804003323.1441376-1-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804003323.1441376-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 05:33:22PM -0700, Kuppuswamy Sathyanarayanan wrote:
> +/**
> + * struct tdx_report_req: Get TDREPORT using REPORTDATA as input.
> + *
> + * @subtype        : Subtype of TDREPORT (fixed as 0 by TDX Module
> + *                   specification, but added a parameter to handle
> + *                   future extension).
> + * @reportdata     : User-defined REPORTDATA to be included into
> + *                   TDREPORT. Typically it can be some nonce
> + *                   provided by attestation service, so the
> + *                   generated TDREPORT can be uniquely verified.
> + * @rpd_len        : Length of the REPORTDATA (fixed as 64 bytes by
> + *                   the TDX Module specification, but parameter is
> + *                   added to handle future extension).
> + * @tdreport       : TDREPORT output from TDCALL[TDG.MR.REPORT].
> + * @tdr_len        : Length of the TDREPORT (fixed as 1024 bytes by
> + *                   the TDX Module specification, but a parameter
> + *                   is added to accommodate future extension).
> + *
> + * Used in TDX_CMD_GET_REPORT IOCTL request.
> + */
> +struct tdx_report_req {
> +	__u8  subtype;
> +	__u64 reportdata;
> +	__u32 rpd_len;
> +	__u64 tdreport;
> +	__u32 tdr_len;
> +};

Any reason why reportdata and tdreport aren't "void *"?

> +

