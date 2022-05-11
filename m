Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012D35234BB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237502AbiEKNxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244213AbiEKNxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A3722DD56
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652277195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lA4geVyOxRQyAI3c8C3u5d9Je5L+YOhU/m/ISVgHoMw=;
        b=NrMPg3S11WS7DgKlyOVBv/imTimKZuz3/1bXvxwhIXR/tDOswvkTiKF4AHcmjLPOxjs2r2
        vWFX5+UXGeeHC5A1Zcxps7L+4mryyliulHTvXQl/vbalIElLD9Gjk06a5sWhQhAlg7/jYX
        c48xAjDEM0P327znx9e3OhxraP5e9ts=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-_y5KDllKOl-BaprV_Dn_sw-1; Wed, 11 May 2022 09:53:13 -0400
X-MC-Unique: _y5KDllKOl-BaprV_Dn_sw-1
Received: by mail-ed1-f70.google.com with SMTP id r8-20020a056402018800b00428b43999feso1381724edv.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 06:53:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lA4geVyOxRQyAI3c8C3u5d9Je5L+YOhU/m/ISVgHoMw=;
        b=wpIPJr57A2ZTW/+E3Mtn2v6do8EcQo1SSy2atVTni/eEjTE5AFP+4kbjKdP7gWDZcH
         QFszQ4lxaI8GDUkPB2z3qVGPYyyhZoH8aRxqcVCDdXvM1VnLNa0FZnCX7EhrrD7ieHiM
         8MPd/ovseDAqCLW684Hz64Iqwxe6VoCmhKgrdCvKiCGyRm1H0DkZKfyz0ECaVVuZe42z
         ny3QBZSSaeM9kVnkKHbjZ2FdjReC2Hvvnj0lX0DkLeNDpAf4Fx3EQsiDDD+F1737P17f
         V0bwxS+pyjjVTIPMeaJgmogrKMSEJ00WyOvjO06mbnF1t07BtDRcWP8f+clMOfOxiUzY
         l1lg==
X-Gm-Message-State: AOAM533BH/ovNNyikGyhu7ItS34lVFCHv8N9Rvbra2F41jjf5GUDViT+
        tNoksTl1VVDk2+3s8li54LCXUO7LrhNaIJK5pba4MYBp/voIl+Ek+MV+JZuYijT4VcNM91FMgEh
        AvwFKxb94sN3n3KDuycmUYVlT
X-Received: by 2002:a50:9ecc:0:b0:428:73bd:4667 with SMTP id a70-20020a509ecc000000b0042873bd4667mr25199313edf.165.1652277192826;
        Wed, 11 May 2022 06:53:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNpPcqaDgy6ACO49WlAIYSxJh/Gjw8KqLpHuWmE+kyyTZCgKq/Nd8OS+KXR+G0Eeja4jW/jw==
X-Received: by 2002:a50:9ecc:0:b0:428:73bd:4667 with SMTP id a70-20020a509ecc000000b0042873bd4667mr25199294edf.165.1652277192638;
        Wed, 11 May 2022 06:53:12 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id dx18-20020a170906a85200b006f3a8b81ff7sm1061918ejb.3.2022.05.11.06.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 06:53:11 -0700 (PDT)
Message-ID: <7541c9c1-a580-92d1-1261-3cf3ef756215@redhat.com>
Date:   Wed, 11 May 2022 15:53:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 16/22] KVM: x86/mmu: remove redundant bits from extended
 role
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20220414074000.31438-1-pbonzini@redhat.com>
 <20220414074000.31438-17-pbonzini@redhat.com> <Ynmv2X5eLz2OQDMB@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Ynmv2X5eLz2OQDMB@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 02:20, Sean Christopherson wrote:
> If it's not too late for fixup, this should be:
> 
> 	return is_cr0_pg(mmu) && !mmu->cpu_role.base.has_4_byte_gpte;

It's not, thanks!

Paolo

