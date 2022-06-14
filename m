Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D0654ACF7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 11:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346003AbiFNJJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 05:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiFNJJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 05:09:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AB783F300
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655197781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fqpJcLN60n/oxpIs0LtaQ1aioLaFYc4ZRvhjhKAC5Vw=;
        b=iCSV9A9gMX9QcP1xTTQxJo4aqkiLero5bQdO6sQqEcAqWAK/8q9guKODD6qikWYcmbM0kd
        FvPknjguAuAzQxKHcywc39An7KQx1W3+hmZG9XGawNVDvrQ/rT4nU+85L5E6BbqAFn0c8A
        3YyAUFNbCqa9dxybAk4DXDMINY6SvgQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-e46UR2kPOiqTNgb2gccR7g-1; Tue, 14 Jun 2022 05:09:38 -0400
X-MC-Unique: e46UR2kPOiqTNgb2gccR7g-1
Received: by mail-qv1-f72.google.com with SMTP id ke5-20020a056214300500b00461fc78b983so5498312qvb.17
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 02:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=fqpJcLN60n/oxpIs0LtaQ1aioLaFYc4ZRvhjhKAC5Vw=;
        b=Ll+dT/WrQ1Waf0HmwZ32Q/CYV/Bva0ozF4U/1YmauUAxgwEk83HGqtzR19D1CnIDIT
         CIEVqSb3WuIUei9TvXruj2h5TOxRdGG95AtqfC41sC+6+Xa7ZEq7NN0sPS/jVEhlRBKC
         2TgzQwpLTTBRgtS1HJB4Lah0Frk2LYeaC/M78vjfBDjRm/LxB7Y8X3s/FSMT/JtQmHju
         +b8Di8qSzb/rZXsvClbECBp9FqHsGoia+NqbOd//stri0rUHO3/l+9EGEHZt9iZPmjfS
         JY4p364iQgONDxkOoTLtZ+TsW7MAHbCGb5QjtxuQF+Gz9uazY0AUhHarVfwKxn1MTSox
         zLqA==
X-Gm-Message-State: AOAM531T+A/bZ0jMBRdGWCeDjsRM9dxAWKuCW2KUJ4LYQ8TI6vvWaIuB
        6K+pvToqBK4uNxtxA6J0wAvYNgmqJFVYtyOWpQdGAWXx9+8rmFORbjQj/NqSJS3mgY1JHl3oNGV
        ma8M+gkCPoLyGQ7xh74qQU2RG
X-Received: by 2002:a05:620a:12eb:b0:6a6:bdb3:c10 with SMTP id f11-20020a05620a12eb00b006a6bdb30c10mr3173586qkl.484.1655197778040;
        Tue, 14 Jun 2022 02:09:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAQcS4/r38M2MKP9bVcXjDJ4j7q5b11NA6bZJwSVj8LTqvXjbU96zh64NbxzTasZcTMKHE0g==
X-Received: by 2002:a05:620a:12eb:b0:6a6:bdb3:c10 with SMTP id f11-20020a05620a12eb00b006a6bdb30c10mr3173568qkl.484.1655197777804;
        Tue, 14 Jun 2022 02:09:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-202.dyn.eolo.it. [146.241.113.202])
        by smtp.gmail.com with ESMTPSA id d1-20020a05620a240100b0069c72b41b59sm9347770qkn.2.2022.06.14.02.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 02:09:37 -0700 (PDT)
Message-ID: <5e5580c4d3f84b9e9ae43e1e4ae43ac0a2162a75.camel@redhat.com>
Subject: Re: [PATCH v2 net-next] dt-bindings: net: xilinx: document xilinx
 emaclite driver binding
From:   Paolo Abeni <pabeni@redhat.com>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        harini.katakam@amd.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@amd.com
Date:   Tue, 14 Jun 2022 11:09:33 +0200
In-Reply-To: <1654793615-21290-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1654793615-21290-1-git-send-email-radhey.shyam.pandey@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-09 at 22:23 +0530, Radhey Shyam Pandey wrote:
> Add basic description for the xilinx emaclite driver DT bindings.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

Even if marked for 'net-next', my understanding is that should go via
the device tree repo. I'm dropping from the netdev patchwork, please
correct me if I'm wrong, thanks!

Paolo

