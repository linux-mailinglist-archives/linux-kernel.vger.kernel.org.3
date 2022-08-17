Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E494E5973F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240989AbiHQQQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241134AbiHQQPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8289CA1D47
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660752887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YdM4kHQtSkRiqBeJJNERoQcyD8v2KLZOZ12Pd7Uk/lE=;
        b=O3oFtDrgp0ANiQlEzwv+S+ZU+OXDc170Zo70N1lo0wNQTlhGpxFJD1ZfJ5Gc9+o6AQgull
        vhWsr9pCIV71MVCsFPXHx4XVLLkyNQgY+nmYsIiw/8AQu8wacfzJyM/qi0Z/rPhM1y59Nb
        W5j7Sh/Vh6WbbJ+Vd6qpnM5Ru0q/3HI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-etW9xttMOc2PBA5nRs9m5Q-1; Wed, 17 Aug 2022 12:14:46 -0400
X-MC-Unique: etW9xttMOc2PBA5nRs9m5Q-1
Received: by mail-wr1-f72.google.com with SMTP id m7-20020adfa3c7000000b002251ddd0e05so1023464wrb.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=YdM4kHQtSkRiqBeJJNERoQcyD8v2KLZOZ12Pd7Uk/lE=;
        b=AMtO3a3bk2ZhTx/ivC5jcMkRYtQfaSTwrC741xGyKgfPy0pntEfRQMQRr6XJS3Q0EG
         v3kxm09X82Yz8z9Y20SMpL4gBLSA5IAJuPqVlfh92x7S0bo7MvhKia/nEH8cR8v3m6hp
         8pNhGGQbUmRJ6QCPv2xdaFK0KA3qT8d5QuUSF8qVr71hC+5EYzRuvKdVP/Cfd/VHPs7j
         DMs3ve1PsYjdN4A+Kib2WlusTCSf/SOlP2FmYzeplj/9GKxga2PIcMSzcnrmcVnUIPIP
         TnA1wYjf8y5r8w2nyIm5wQEdeoEZnSRr8n5IvNqreMMb8RUyqwnCb+suz7Gj5VidSLl3
         pElA==
X-Gm-Message-State: ACgBeo2MxMbKxSaTwmdyZQ0SuYwYpRXS3GoVzcaz4P3vTcAmL3sZBkTk
        mQh4mQf5n8twPewGrGrWihLAe0gbOsU/N8KmGHMPtPTbnNdjvShLDn9T3TNTN0TFikFGB5ZCHgi
        EeQZFfucv/MjL1fu9E8SM3xg1
X-Received: by 2002:a05:6000:783:b0:223:93d0:3286 with SMTP id bu3-20020a056000078300b0022393d03286mr14474360wrb.347.1660752885171;
        Wed, 17 Aug 2022 09:14:45 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5dE69vIM/TuWC85NWQRObP4zFra/YXjMzBRsTYnz7YgvqHv3toBl6Lxi9+7i5LNYU4TNPCSQ==
X-Received: by 2002:a05:6000:783:b0:223:93d0:3286 with SMTP id bu3-20020a056000078300b0022393d03286mr14474345wrb.347.1660752884937;
        Wed, 17 Aug 2022 09:14:44 -0700 (PDT)
Received: from work-vm (cpc109025-salf6-2-0-cust480.10-2.cable.virginm.net. [82.30.61.225])
        by smtp.gmail.com with ESMTPSA id m128-20020a1c2686000000b003a5dbdea6a8sm3106591wmm.27.2022.08.17.09.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 09:14:44 -0700 (PDT)
Date:   Wed, 17 Aug 2022 17:14:42 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, tglx@linutronix.de,
        leobras@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Subject: Re: [PATCH] KVM: x86: Always enable legacy fp/sse
Message-ID: <Yv0T8iFq2xb1301w@work-vm>
References: <20220816175936.23238-1-dgilbert@redhat.com>
 <YvwODUu/rdzjzDjk@google.com>
 <YvzK+slWoAvm0/Wn@work-vm>
 <Yv0TN0ZI0LNFMGQD@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv0TN0ZI0LNFMGQD@google.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Sean Christopherson (seanjc@google.com) wrote:
> On Wed, Aug 17, 2022, Dr. David Alan Gilbert wrote:
> > That passes the small smoke test for me; will you repost that then?
> 
> Yep, will do.

Thanks.

Dave

-- 
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

