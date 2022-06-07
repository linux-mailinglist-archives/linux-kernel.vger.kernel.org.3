Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D198053FECF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243733AbiFGMcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243133AbiFGMcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D8F4DB1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654605131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ANIP068Q0mpb/xLRKoLbXp2Q0bL3F9C9hqR31yN4fgA=;
        b=cp9fnpaytGnC5EaZY30nJhZ4sMcVNs6ce63tR1P/Rb1nhvGujKiZ62a6gCN3LvMJoETtfg
        gFAK1U465SwtT0Q9HY0n0pqg0trxxx47DIdLYUSEyn662NMmal1U8Ctybqf9wh8urhNq54
        TZDX+KUGJF0pnGEYrLLyrjJ3YDMf0Ds=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-nHvFmEDcPgaxI5X6ZeO9Bw-1; Tue, 07 Jun 2022 08:32:08 -0400
X-MC-Unique: nHvFmEDcPgaxI5X6ZeO9Bw-1
Received: by mail-qt1-f200.google.com with SMTP id c1-20020ac81101000000b002f9219952f0so13803860qtj.15
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 05:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ANIP068Q0mpb/xLRKoLbXp2Q0bL3F9C9hqR31yN4fgA=;
        b=eSwzbq/DUDMvyBaOtnStKZiZtKxZ0wfthENrIA7YDC1jrluDoDV8NfuaL0KwgJZlb5
         sDlwkFh3ZBaitQ32kZR7tzBEMwOHPYcw2Qog9onRCraCYyQ3XTTkyZgHVaYr5jYo0yyu
         S8PJOuSnfsP0ZpJAUE/jWRiAdp+BpEnlHN2JebihaVMBU+80XWLzMI7ckVw85YaYsM/p
         ahzLzUHS8CUN8dmIuTws+N3a4nNxAlI0edXgp17IfyFcyOFzJVokFGDVe64/pk9yEpXy
         5w5p72x6rR//XXyjwqN/u1htD6HKbX0tPC5nIUeKQuowTznmzPg5P473fKfcEvs6U1B9
         +/hg==
X-Gm-Message-State: AOAM531z1B6PoTMrCeIXc2U8Q8wV6QEZYS/FUAdS64Athucgz1u4P6M4
        UupQ6zSMN0ZiBbSBORNEcG1dSYssO47DsY5bwgcsIEBII6MmzFaBInc1jTTFvcgPZa4MpkmPa0Z
        /dpgkhTp+SYOydBELeW7eU2Sf
X-Received: by 2002:a0c:f911:0:b0:465:3bef:4699 with SMTP id v17-20020a0cf911000000b004653bef4699mr20609182qvn.111.1654605127645;
        Tue, 07 Jun 2022 05:32:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAmnEscpLoS4SpG191ElQwv6uk00aXYwAdm24AqlPzMdN/j2XL170KAdBJbh1UhMVtqJ0Lug==
X-Received: by 2002:a0c:f911:0:b0:465:3bef:4699 with SMTP id v17-20020a0cf911000000b004653bef4699mr20609144qvn.111.1654605127181;
        Tue, 07 Jun 2022 05:32:07 -0700 (PDT)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id bt4-20020ac86904000000b00304febfc2ddsm14585qtb.56.2022.06.07.05.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 05:32:06 -0700 (PDT)
Message-ID: <72b2c30861566c366deff686e965db53694e8f8f.camel@redhat.com>
Subject: Re: [PATCH 1/7] x86/cpu: Add CPUID feature bit for VNMI
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Santosh Shukla <santosh.shukla@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 07 Jun 2022 15:32:03 +0300
In-Reply-To: <20220602142620.3196-2-santosh.shukla@amd.com>
References: <20220602142620.3196-1-santosh.shukla@amd.com>
         <20220602142620.3196-2-santosh.shukla@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-02 at 19:56 +0530, Santosh Shukla wrote:
> VNMI feature allows the hypervisor to inject NMI into the guest w/o
> using Event injection mechanism, The benefit of using VNMI over the
> event Injection that does not require tracking the Guest's NMI state and
> intercepting the IRET for the NMI completion. VNMI achieves that by
> exposing 3 capability bits in VMCB intr_cntrl which helps with
> virtualizing NMI injection and NMI_Masking.
> 
> The presence of this feature is indicated via the CPUID function
> 0x8000000A_EDX[25].
> 
> Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> ---
>  arch/x86/include/asm/cpufeatures.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 393f2bbb5e3a..c8775b25856b 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -346,6 +346,7 @@
>  #define X86_FEATURE_V_VMSAVE_VMLOAD    (15*32+15) /* Virtual VMSAVE VMLOAD */
>  #define X86_FEATURE_VGIF               (15*32+16) /* Virtual GIF */
>  #define X86_FEATURE_V_SPEC_CTRL                (15*32+20) /* Virtual SPEC_CTRL */
> +#define X86_FEATURE_V_NMI              (15*32+25) /* Virtual NMI */
>  #define X86_FEATURE_SVME_ADDR_CHK      (15*32+28) /* "" SVME addr check */
>  
>  /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 */

I also think that AMD should publish some sort of a 'future ISA' spec like Intel does,
so that we could avoid mistakes in reviweing the code.

Other than that:

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky

