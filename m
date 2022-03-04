Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCB84CCFC0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiCDIOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbiCDIOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:14:16 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07F45F4D3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:13:28 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 614223F600
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646381607;
        bh=u92RN98xsaKKvVR2ERLhxgw0jvDHnJIgkodjW6Vmrfc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=YunaedYZKR7N3MT3a0R1U+Zdi+/32lTKLY83UuwhtFuBOxvWfGx5mH7ooR02wgaJg
         PR/weFcEsUlbbX3QD5fnCKZZ7jZHHUVumgzITbeklTi3sNCazdn+OcDaBL9D/EReTX
         tLWeNyPaoSaBpVTHe3O1D3jwv4RoNFQVIVrTzBIvf8KgdNBlMuPf0ox6tzd06yis1+
         pvjjwcWdglLL5tS9tn+os44cX6cqs6Gv616LOCTacwsCIrzMiIJmPR7saJWJaNoQ3/
         Qvsshw3yiKdjK3BB91W4Al87/tEn04fKgamZ0h7PkO+v6J/U8Edo/b1A7Flcceicuy
         ZqyXQTwzlYYkg==
Received: by mail-ed1-f69.google.com with SMTP id da28-20020a056402177c00b00415ce4b20baso3302736edb.17
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 00:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u92RN98xsaKKvVR2ERLhxgw0jvDHnJIgkodjW6Vmrfc=;
        b=Z7GXU1fSAaD/YXG1OdPESwBc6VtVlPzNKPmVRhqwBD9DYIlCPm7H8lQHt4uHizAh9A
         N1U3ZQAgT/BNOaK2P1Pvd7WFoYRYS7NXbj5+OZyXYMqvRSUISaTM8IFdA9B0KTK0rVD7
         dYDZCxCVKSdwVz1c4vEMrQA7elzMrW9JvBppC6UKrvu0liv8Z4aQv7ysc0jbDUK4pdeJ
         sOPnMQTZNwArmxDdRP2dWFhUPflsYPQQfatrI1oO+wmPnDlbQewZ83HZTIMTbia6VL5Z
         /OgTTXCWjuhkeVL8V78eY7gTLPF3YKEIPOoJSdIwPJQKmovvC0waTpAcJzG1twXThmp3
         fF9A==
X-Gm-Message-State: AOAM533xOFbb8Oaen2M1JTHLeIHcfYVdj2JgR1g9RGA/J1c0iXszTn9Q
        x4uTMcLin6qgjSjaIH2Hx3URh3JEb/T75w9nctnGfLYO+9pdvyxT0JVvUkyXuY155p4i6PR6HWX
        ySSGFNIYVGa96Z3g0BJ57ZNpltUsaPL/08cyizc1zww==
X-Received: by 2002:aa7:dc0b:0:b0:413:ce06:898e with SMTP id b11-20020aa7dc0b000000b00413ce06898emr20632135edu.244.1646381607145;
        Fri, 04 Mar 2022 00:13:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzHVFpb9pcKzIsU+u8jGdacY8s7CiobV44+qtSKwFkIpzEns5bh4tB/F0Pbuul2ITbKhDIeLA==
X-Received: by 2002:aa7:dc0b:0:b0:413:ce06:898e with SMTP id b11-20020aa7dc0b000000b00413ce06898emr20632124edu.244.1646381606957;
        Fri, 04 Mar 2022 00:13:26 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id z2-20020a05640235c200b00415cec386a5sm1889584edc.16.2022.03.04.00.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 00:13:25 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, ssantosh@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: emif: Add check for setup_interrupts
Date:   Fri,  4 Mar 2022 09:13:22 +0100
Message-Id: <164638154584.220122.188776501757367125.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220224025444.3256530-1-jiasheng@iscas.ac.cn>
References: <20220224025444.3256530-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022 10:54:44 +0800, Jiasheng Jiang wrote:
> As the potential failure of the devm_request_threaded_irq(),
> it should be better to check the return value of the
> setup_interrupts() and return error if fails.
> 
> 

Applied, thanks!

[1/1] memory: emif: Add check for setup_interrupts
      commit: fd7bd80b46373887b390852f490f21b07e209498

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
