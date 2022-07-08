Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C485756BF63
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 20:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239547AbiGHSb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 14:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238757AbiGHSb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 14:31:26 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D76512E;
        Fri,  8 Jul 2022 11:31:25 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y4so14461071edc.4;
        Fri, 08 Jul 2022 11:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=36rF+EA9uWT2mpDidJKHhWxhm7lBZsbuip/44O/He84=;
        b=nZeY9K8WaHz5JD5ODEhu/zIQe4g+MprhpHQMx5NXH6omtiCN8zigVz2fSVcqhdDJms
         nQ8k0otOaI9HEXXEIHmPujzhLPR5no60CqGH9jtoAxvOpQSnVzScGrlbRyhnNg/QQ+sr
         rnsZVmKxskDfo5XiFG+4P8vx1ZA0TARB4gMbsgD3F54TfTloOm4n9Vy3bfK7vmyQRhxZ
         UaJmrF/KirG1hicB8K8ZlgFTuhiklPgwvOrkUMphy4Cddfromg0RM2y8n0LBoaBIs8SV
         eJEuOwiNY5YqWCT2WYJbLHs80b6BUWRd8giO+5gVJXfClKML1CmHoKzwzfvR35hEY9ub
         bzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=36rF+EA9uWT2mpDidJKHhWxhm7lBZsbuip/44O/He84=;
        b=KoMJtlLkC+2xcbwv+NmPqvAhiCdsJ9Xo2TgJNgP+WYz27XnoZskhSyOZgY+lFTX4Nx
         RYgpcSuCUZH7G1WdNzKGxMN7ViVZeeBO7Dymt11FLPCB6lDJG62RCz443Spt70a9qz78
         IhXDdfP+YzxcYMGrFRBHxKQ0n8QkGy8adfa5wFAk6X1DaaCpr0WUekLBozf4cSnB//aS
         Jct7AuT+rIWgJ23Uw9YVDRsqKr2A/0XhPl50eLUuaK6EGbcwkUwREn0lEb+GhlewDM/w
         GAIq1yG6n1uVPtSQhX8sJ1l2reUTmVsnMuHedPCkPZ2Z7ONvOVUofKZj7bsuQTUxB0kz
         0G/A==
X-Gm-Message-State: AJIora+Pst5iH84uOLAAMwr+LU3rBBolrvrxscm5wUOrDl326tYfyQ6s
        E/3ZG2sa4Y+rON9kA+1rC+Q=
X-Google-Smtp-Source: AGRyM1uMFV4eY7pt9h2ChiX00tWhYrTNc4IF6JZgK/pJE3XvGVynvEOrkEPJp+VKO1Wes1398mV+Gg==
X-Received: by 2002:a05:6402:500b:b0:431:78d0:bf9d with SMTP id p11-20020a056402500b00b0043178d0bf9dmr6553702eda.184.1657305084077;
        Fri, 08 Jul 2022 11:31:24 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id w3-20020a1709067c8300b00722fc0779e3sm20628128ejo.85.2022.07.08.11.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 11:31:23 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@lists.linux.dev, Michal Suchanek <msuchanek@suse.de>
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: sunxi: Fix SPI NOR campatible on Orange Pi Zero
Date:   Fri, 08 Jul 2022 20:31:22 +0200
Message-ID: <2128843.C4sosBPzcN@kista>
In-Reply-To: <20220708174529.3360-1-msuchanek@suse.de>
References: <10106175.nUPlyArG6x@jernej-laptop> <20220708174529.3360-1-msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 08. julij 2022 ob 19:45:29 CEST je Michal Suchanek napisal(a):
> The device tree should include generic "jedec,spi-nor" compatible, and a
> manufacturer-specific one.
> The macronix part is what is shipped on the boards that come with a
> flash chip.
> 
> Fixes: 45857ae95478 ("ARM: dts: orange-pi-zero: add node for SPI NOR")
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Applied, thanks!

Best regards,
Jernej


