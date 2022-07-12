Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE23657194D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbiGLL7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiGLL7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:59:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 133C14F66C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657627135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U7QIDSxZFUYXNY6pVprVvC57ag3whDjnsY/JfggEm9w=;
        b=Wk3XclE4RrSc9s6Fwr5u4UR9W1HQcbLIwNoQLa0m45yBvnGXJ0BrVMc/R1pFnqYX4t2GhQ
        0ZEcM3f01SI4MUNTiJb/NInbQvxOApxNP5y2aCIcJ8jS2pZxc/E0uDI0IfwL7WfSGDmzdw
        X1SaMIyiV2zitLWTJmg+DN1yIHc5oDg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-8cYwD3g1NGaYn30Z1CO1Kw-1; Tue, 12 Jul 2022 07:58:54 -0400
X-MC-Unique: 8cYwD3g1NGaYn30Z1CO1Kw-1
Received: by mail-qk1-f199.google.com with SMTP id o13-20020a05620a2a0d00b006b46c5414b0so7688700qkp.23
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=U7QIDSxZFUYXNY6pVprVvC57ag3whDjnsY/JfggEm9w=;
        b=BWX7YPF6qSSYtx+IeuMc+9kNRf8NVjxmvjTLvfcoRk6G/lVbvaOFeuOrUEu0ZmEwAX
         xx9vEHFiJkUIHgo9ux1ltUgzR7Dq342/rIkF5UIV3JHxPukJMGS3QT6nQQyPIL7ua5XY
         3iw7o/YZlEQAk4OlJr/bqKoL+fOjcYpoZHCgZ7vUSs+GuJKYjBDv0TeosI+BDVTvaXBd
         8GOeai6TWpHMvXMFCAhdCvjGN3Gbd5OOT/uOmtZ8BRX7piChH0MO13vwcRbIr5LeGuS5
         Pn36NzxjiAhLv5cVCDSI5GIrrQXR3IneaHELlJmBE4lWSb4VL94qpl2NVfXwRWRyDydi
         zCmg==
X-Gm-Message-State: AJIora8ljzbgnvMJ1Bef6lPqR2TGP5ejskGITKFHBXhBm+Ci2JhW3GGT
        dLLvaLupmt0pDuURFAFQhFBSkpNpDzVE47r/YVpkFsXQaZ04dryEYNSrVrvyfl/UVxtYdaE1xXP
        ENAE7DC4ERu8oYY8yzQfA6zIU
X-Received: by 2002:a05:622a:1482:b0:31e:9c01:ed76 with SMTP id t2-20020a05622a148200b0031e9c01ed76mr17567954qtx.547.1657627132202;
        Tue, 12 Jul 2022 04:58:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tksyjUqV7B20gdvMOv4LZE1LenmZxesRu/qi13zSNQNrALL51hn8UahTbmHqtcAR2R0Kuekg==
X-Received: by 2002:a05:622a:1482:b0:31e:9c01:ed76 with SMTP id t2-20020a05622a148200b0031e9c01ed76mr17567880qtx.547.1657627130522;
        Tue, 12 Jul 2022 04:58:50 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id k18-20020a05620a415200b006b5905999easm4619740qko.121.2022.07.12.04.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:58:49 -0700 (PDT)
Message-ID: <0a17abb673be4042ab06eb999fe5676519b4101c.camel@redhat.com>
Subject: Re: [PATCH v3 20/25] KVM: x86: VMX: Replace some Intel model
 numbers with mnemonics
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 14:58:46 +0300
In-Reply-To: <20220708144223.610080-21-vkuznets@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-21-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-08 at 16:42 +0200, Vitaly Kuznetsov wrote:
> From: Jim Mattson <jmattson@google.com>
> 
> Intel processor code names are more familiar to many readers than
> their decimal model numbers.
> 
> Signed-off-by: Jim Mattson <jmattson@google.com>
> Reviewed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index eca6875d6732..2dff5b94c535 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2580,11 +2580,11 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
>          */
>         if (boot_cpu_data.x86 == 0x6) {
>                 switch (boot_cpu_data.x86_model) {
> -               case 26: /* AAK155 */
> -               case 30: /* AAP115 */
> -               case 37: /* AAT100 */
> -               case 44: /* BC86,AAY89,BD102 */
> -               case 46: /* BA97 */
> +               case INTEL_FAM6_NEHALEM_EP:     /* AAK155 */
> +               case INTEL_FAM6_NEHALEM:        /* AAP115 */
> +               case INTEL_FAM6_WESTMERE:       /* AAT100 */
> +               case INTEL_FAM6_WESTMERE_EP:    /* BC86,AAY89,BD102 */
> +               case INTEL_FAM6_NEHALEM_EX:     /* BA97 */
>                         _vmentry_control &= ~VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL;
>                         _vmexit_control &= ~VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL;
>                         pr_warn_once("kvm: VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL "

I cross checked the values, seems correct.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

