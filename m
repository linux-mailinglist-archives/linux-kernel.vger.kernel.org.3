Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF9350B4DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446500AbiDVKXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446519AbiDVKWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1095E54
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650622795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gDpFNRt/1Nv6dTGMaWYqyfp95hfZrrFPcpbVHbafv2s=;
        b=hCLx/W+QWvhX3s27BLtE5nuek0puB+SdquJXYNv9hTfDpmVx/Kog3iKyN2l6GbaK1kwpSQ
        3ceAOH0XRei40zUfUmkE5PtSQmPqa+/sI4ejYGEbPoPsi8j+y+69iK/Get67Eytt5mrOGj
        rWcHaagbYj0w41zDKs17WVwCl+4snSY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-B4uhPSUPNy20SPoijIJfaw-1; Fri, 22 Apr 2022 06:19:54 -0400
X-MC-Unique: B4uhPSUPNy20SPoijIJfaw-1
Received: by mail-ed1-f69.google.com with SMTP id l24-20020a056402231800b00410f19a3103so4744658eda.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:19:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=gDpFNRt/1Nv6dTGMaWYqyfp95hfZrrFPcpbVHbafv2s=;
        b=UAWN3O5cpAD9DLOht+oH8mln/0utIBCKTmsquT0gwn9quLNWTHHGh328TaQLUYuuHk
         1vqYPx6C+ZdpWH2tQnxkDbL7xUGyWcWXkd6M9DZ7QksI4T+hrWPjv/SvBvbnctOk0Tu6
         iT6AG3QX7mNgokAWjE7RJkc4ECFFjbvixV61gHUEc0iAj69L1R+lPbps7pTWEriM38G2
         iLL6jilSEIFsPHg0DqXYI2UqkRLyEpen7yKFcHum2tIjK3ZsX+NzxEhBuQfnEdNDamW9
         WSxqSXgg5lY4SayzDVejG490rTI1eTGmvA8QfnIXlUYJ8TNjsjpEN5nhajiicrPyv3ea
         mL8Q==
X-Gm-Message-State: AOAM532gVWP/5WZa2awgdTcyYpCPGgt3nCI6thFEMX5j2qsc07G9Ene7
        wt7rfTeOz8sT8QtFFoblX4drNSijuvxByGrMurI6o3OJn3ZmMRzwWXWGZWtBk8JrTfciJR6smjk
        aThjSTcpFT7jM/8ksmokuQul8
X-Received: by 2002:a17:907:9804:b0:6ee:f915:9c25 with SMTP id ji4-20020a170907980400b006eef9159c25mr3334283ejc.121.1650622793709;
        Fri, 22 Apr 2022 03:19:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhNTy/6tsTfHINgWNg5Xxy8UNJWoMTKRIlfTbprUKQrQTcK0XKESr6kbbQ+ZB8UzLmznTNPg==
X-Received: by 2002:a17:907:9804:b0:6ee:f915:9c25 with SMTP id ji4-20020a170907980400b006eef9159c25mr3334262ejc.121.1650622793432;
        Fri, 22 Apr 2022 03:19:53 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id bp5-20020a170907918500b006f022c102a4sm602143ejb.124.2022.04.22.03.19.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 03:19:52 -0700 (PDT)
Message-ID: <36978590-c714-d0ba-6e4e-ab0016136381@redhat.com>
Date:   Fri, 22 Apr 2022 12:19:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, will@kernel.org, apatel@ventanamicro.com,
        atishp@rivosinc.com, seanjc@google.com, pgonda@google.com
References: <20220421180443.1465634-1-pbonzini@redhat.com>
 <YmJgIQe+5zGbrxoF@google.com>
 <ef5c6c5b-2ed1-7d4c-e757-ed8bcead5d18@redhat.com>
 <87a6cda13p.wl-maz@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/4] KVM: fix KVM_EXIT_SYSTEM_EVENT mess
In-Reply-To: <87a6cda13p.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 12:01, Marc Zyngier wrote:
>> These patches are against kvm/next, so that is already what I did. :)
> 
> Can you please post a complete series? It is becoming really hard to
> track what you are doing.

Yes, I'll post a complete series for kvm/master in a second.

>> On the other hand right now the ARM and RISC-V flags are unusable with
>> 32-bit userspace, so we need to fix _something_ in 5.18 as well.
> 
> What 32bit userspace? arm64 doesn't have any that can interact with KVM,
> so I don't see anything to fix on that front.

You're right, ARM64 does not define KVM_COMPAT.  But RISC-V does.

>> For your proposal, all that's missing is a 5.18 patch to add the
>> padding. But since the flags UAPI was completely unused before 5.18
>> and there's no reason to inflict the different naming of fields to
>> userspace.  So I think we want to apply this UAPI change in 5.18 too.
> 
> As it was pointed out already, CrosVM has already started looking at
> the flags. The fact that it was always 0 until now doesn't make it
> less of a UAPI.

I heard that and that's exactly why I dropped the idea of using 
NDATA_VALID in bit 31 of flags, and switched to a capability instead. 
If it is desirable for Android, crosvm can "quirk" that ARM always has 
valid data[0].

Paolo

> I'd like to see a full series that implements the transition before we
> make a decision on this.

