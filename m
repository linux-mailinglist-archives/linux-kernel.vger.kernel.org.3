Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62B157190A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiGLLxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiGLLxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:53:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0B6AB6542
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657626723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X6w0674s9ili7eArWVuDLnAMEL/ug8bcR3ZZcjz90CE=;
        b=ftkTFSd6uoqAKsuawDclIPJwy8GUChX4PVBnPPm7A9sUKEjd9OfdRUO88LrAImUG6NnDe2
        EDEoIKxDwDQjU/OstYTiSMuRPVzBhSJSk5G5gk1IqtAqXa22+x1CG3DJ+BXGMjA1rqfku+
        LrhzZ70UdtEubXUL6XT9rdemfUndB3I=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-qC90wFv4NqiAKiGsSZJWtw-1; Tue, 12 Jul 2022 07:52:02 -0400
X-MC-Unique: qC90wFv4NqiAKiGsSZJWtw-1
Received: by mail-qt1-f198.google.com with SMTP id x10-20020ac8120a000000b0031ea260a047so6691412qti.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 04:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=X6w0674s9ili7eArWVuDLnAMEL/ug8bcR3ZZcjz90CE=;
        b=r9lMDiXvGvqmFmhm8q38YAKDmFkRFUxwqbNRO5K7h1EGz0IKgWTWbFRSb1oRKIK4EG
         ZHbCnpXC0VT7qYOsl5Jle8HGatL45jBfM1fwmY3mK56blBzqufEkx9dTZs1DzH62B004
         nfPFtMjupjFj1L7Trxy91c8z1GXT30hFJtwDE3BAiTaewmtFVAnqzQuYCvYao+4jZdSJ
         LlP5sNgRi4eiQ1eyTIk4EHd8UzeV1CLpJLgC9MNtma2/2dx/9qQ6b5Mki9sA4a5G0mAA
         N1xCoCQO0LJdmUV5I6e3I0xeNZT41Q3DCG4m7vqos8bsXP8SOglEkwtbLQY/NPLfIglr
         Vgmw==
X-Gm-Message-State: AJIora9L5Qj50g9Hgh9q2wO0asiHhkM3AmPXm7jOczRB2m/mlJCMbUGy
        JiF+NGY9uzYTMQsQOVITgUUtSrMCpBJRb8fFfWuDsBVdrg6XJiQMYKoP/Hjrf62qdY2YX7Y/BYc
        I+EOf/LzYFmk6Rb4aVUou93uu
X-Received: by 2002:a05:620a:460d:b0:6b5:91f7:62e with SMTP id br13-20020a05620a460d00b006b591f7062emr4923484qkb.487.1657626722506;
        Tue, 12 Jul 2022 04:52:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tOyzMnWtzjI+gxSVBLeO+oFjE5N8UcGZXyfPv0gM8p73Issnk6xlKMnd/qXHM9ma7lLPObww==
X-Received: by 2002:a05:620a:460d:b0:6b5:91f7:62e with SMTP id br13-20020a05620a460d00b006b591f7062emr4923471qkb.487.1657626722298;
        Tue, 12 Jul 2022 04:52:02 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id j9-20020ac85c49000000b0031eac31e630sm7443948qtj.49.2022.07.12.04.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 04:52:01 -0700 (PDT)
Message-ID: <86803b99df343926b9dd4f4089fccd7efb04eb00.camel@redhat.com>
Subject: Re: [PATCH v3 07/25] KVM: selftests: Add
 ENCLS_EXITING_BITMAP{,HIGH} VMCS fields
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 12 Jul 2022 14:51:58 +0300
In-Reply-To: <20220708144223.610080-8-vkuznets@redhat.com>
References: <20220708144223.610080-1-vkuznets@redhat.com>
         <20220708144223.610080-8-vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-08 at 16:42 +0200, Vitaly Kuznetsov wrote:
> The updated Enlightened VMCS definition has 'encls_exiting_bitmap'
> field which needs mapping to VMCS, add the missing encoding.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  tools/testing/selftests/kvm/include/x86_64/vmx.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/vmx.h b/tools/testing/selftests/kvm/include/x86_64/vmx.h
> index cc3604f8f1d3..5292d30fb7f2 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/vmx.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/vmx.h
> @@ -208,6 +208,8 @@ enum vmcs_field {
>  	VMWRITE_BITMAP_HIGH		= 0x00002029,
>  	XSS_EXIT_BITMAP			= 0x0000202C,
>  	XSS_EXIT_BITMAP_HIGH		= 0x0000202D,
> +	ENCLS_EXITING_BITMAP		= 0x0000202E,
> +	ENCLS_EXITING_BITMAP_HIGH	= 0x0000202F,
>  	TSC_MULTIPLIER			= 0x00002032,
>  	TSC_MULTIPLIER_HIGH		= 0x00002033,
>  	GUEST_PHYSICAL_ADDRESS		= 0x00002400,

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

