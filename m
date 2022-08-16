Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6D7596045
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbiHPQ3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbiHPQ3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:29:17 -0400
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C427969D;
        Tue, 16 Aug 2022 09:29:11 -0700 (PDT)
Received: by mail-io1-f44.google.com with SMTP id 10so5154616iou.2;
        Tue, 16 Aug 2022 09:29:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=zjOXR5lg7WgBtM6SMEJ6Ujx/4a4huFvZ+SfdMeMoMxc=;
        b=T6UI4QymnrW5dJxTDvCiGHDIVjIt5XydHlcKNwrTCEBzzXZr1jjLQKV7DYKFzvIjDk
         Ba9TV2t8kreOSshm0VQ4JXNF9qJW79uBNXAOEppgnanf/9Zn1IsFTez3n/bpG73RWjUY
         RpFodz6CpxU0FVuNVFr/LQd6ovAxuyejHOXUeZOB1LYIIOmkXxKv3vMgD353T42YRAjk
         kGiNyqciY79ZaHwrfUnqOqGpJXRHPpOMjvxglAP/rYIpaKRnHv0E/HRJFw/u7xfPF0kC
         qolbm8MJeEKQfCnBQGa8ne0O7jelvgh/eC0uT0vEJFXx3cfmhRjlbI5aH2l95VBI5+w2
         DbmA==
X-Gm-Message-State: ACgBeo1Nhn6eyjmeVrmnvDL09Xpgm2tIvixaE8i6m8JJqmhGGrXzsZqX
        4N+msT5plEDkRA717hrorg==
X-Google-Smtp-Source: AA6agR4bIz/7vqTT1QwM6t3t9ctqD8CfZN/hpZh0arL3DVuqQ/YkZeWd3iNApTf76+7XiENVTawU0Q==
X-Received: by 2002:a05:6602:18b:b0:684:dd5c:663 with SMTP id m11-20020a056602018b00b00684dd5c0663mr8667217ioo.94.1660667349513;
        Tue, 16 Aug 2022 09:29:09 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z25-20020a056602081900b00688b30a7812sm1074756iow.42.2022.08.16.09.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 09:29:09 -0700 (PDT)
Received: (nullmailer pid 2330279 invoked by uid 1000);
        Tue, 16 Aug 2022 16:29:07 -0000
Date:   Tue, 16 Aug 2022 10:29:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] dt-bindings: arm: psci: Relax and simplify compatible
 constraints
Message-ID: <20220816162907.GA2330202-robh@kernel.org>
References: <20220803201639.2552581-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803201639.2552581-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Aug 2022 14:16:38 -0600, Rob Herring wrote:
> Even PSCI v1.0 compliant implementations may support v0.1 clients
> (i.e. "arm,psci"). Relax the compatible schema such that an
> implementation can claim 1.0, 0.2, and 0.1 compatibility.
> 
> In the process, the schema can be simplified a bit by using 'minItems'
> instead of separate 'oneOf' entries.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/psci.yaml | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 

Applied, thanks!
