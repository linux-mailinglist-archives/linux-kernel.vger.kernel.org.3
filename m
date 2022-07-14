Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8CA575415
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 19:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239133AbiGNRdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 13:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiGNRdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:33:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B771FA474
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657820017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0uihKaBOQkwF5deCzOTDYRhxxtwy14Pizt+T/pVs9Yg=;
        b=al4VYPA/9NyqMpBTtyejfFfvv2l/VPXDlHPVE9Tw3sCbPDljAlmZlYJ5nqcYBqAhE0fG7u
        2wOd35TOLfBcnMdo8VUhPCuuCAqCNeEBxHu4dl4xBsHAGuAFT2bwCI+w2kytGnVcK9ZVmD
        guysOigrijNTrH94hbRM8oLa+NBOBsk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-AMo8uhPsPOGOG_Xiv8EPlw-1; Thu, 14 Jul 2022 13:33:35 -0400
X-MC-Unique: AMo8uhPsPOGOG_Xiv8EPlw-1
Received: by mail-ed1-f70.google.com with SMTP id z20-20020a05640240d400b0043a82d9d65fso1908099edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0uihKaBOQkwF5deCzOTDYRhxxtwy14Pizt+T/pVs9Yg=;
        b=AfxhcJAuKA0VIga1hueIWszvR0H6MijyLiC/79AllLf+UlJTkja/4MRWt9f3BXwDrR
         Sg6XxCQ/Pk9audEQrsw/ntSQHzzgjYWJp9V091fXXiMFcnE7Fs2YOPl6VlizZ30XClcJ
         usn0AV3VgpX6/72+gdgDN3ubYDe1TobQh7EejuaBgrY0PfJORixe79oWgkeYAFJUtwPg
         qPHSTRP6BOZIT3XWRD3/5/NXBlWjQKWHV8jfC/3tJnSxjAvci6maef9Pok6VWelNnYf5
         LAcWy5z3Jl62EcTOU87rHxs3pPSWGYKFBzYFO95GJoHIOodBixuP1mnGRyjV7g6t0v7X
         6fog==
X-Gm-Message-State: AJIora8RrW7wK/dOmhcUfup0h2H2RE04gu3ewODAn/PHML8blsIcKHWG
        RpmuW1Z4q41sE/OJp3fLfeU+15Zv+pE1qxl4J48nHBQJ3Emqz6a7qtxC213Ai/NYZs+qrt2aKnj
        SBh6BGFf60+Rk6En8aVeXIe3T
X-Received: by 2002:a05:6402:3214:b0:43a:b36f:a0b4 with SMTP id g20-20020a056402321400b0043ab36fa0b4mr13821023eda.122.1657820014769;
        Thu, 14 Jul 2022 10:33:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vV0UoPqphONFgcUdCBs8koMta1HObDMznrSBqqIdYHhspB9/PNO5wIYVZMH94ltjorGpco5g==
X-Received: by 2002:a05:6402:3214:b0:43a:b36f:a0b4 with SMTP id g20-20020a056402321400b0043ab36fa0b4mr13821007eda.122.1657820014534;
        Thu, 14 Jul 2022 10:33:34 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id h27-20020a170906719b00b0072aeaa1bb5esm920080ejk.211.2022.07.14.10.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 10:33:33 -0700 (PDT)
Message-ID: <747332db-189a-2f58-4a2c-6a40eb631af8@redhat.com>
Date:   Thu, 14 Jul 2022 19:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/5] KVM: x86: Clean up rmap zap helpers
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220712015558.1247978-1-seanjc@google.com>
 <bc2c1af3-33ec-d97e-f604-12a991c7cd5e@redhat.com>
 <YtBR/x3CAEavwzMI@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YtBR/x3CAEavwzMI@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/22 19:27, Sean Christopherson wrote:
> 
>    pte_list_remove  => kvm_zap_one_rmap_spte
>    pte_list_destroy => kvm_zap_all_rmap_sptes
> 
> That will yield a better series too, as I can move patch 5 to be patch 2, then
> split what was patch 2 (the rename) into separate patches to first align kvm_zap_rmap()
> and __kvm_zap_rmap(), and then rename the pte_list_remove/destroy helpers.

Yeah, sounds good (I also was looking into moving patch 5 and possibly 
even patch 4 more towards the beginning).

Paolo

