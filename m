Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4854C7085
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbiB1P1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiB1P1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:27:36 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F897EA1F;
        Mon, 28 Feb 2022 07:26:58 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id l25so13455999oic.13;
        Mon, 28 Feb 2022 07:26:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=I87Fjts+rpNlg39YY3+tnxuJdwSRLJLguMw++XeNFIg=;
        b=pZQVk6Q1OsBDnd6jtsXO0GseRMyEuph5nFUMF55QSKOAqa/q8AU23THpojWsSw1wBe
         fyEPYPBHOynzU4iBPtDdYOoGJfVpPR90DqCU3m4kV+IM7RAobIHpfOqwpMKUAXoIYHzg
         lAeREwT33nC6pRNsL/Vj0O4sdta1HdGta5lOi20ERnJdmfTH8L04p+bAwr2BdnCEkfVx
         QxxHFRy3delX+al5S6gKtkaaeXqjCNYhauuoCXtEh/WcOFegPHZ9tnVjUyguyCPBOYQL
         8N0YvtM058ocf0mwDzuMtwDgjxN2nIaKujhIBSzH6GpczBeqgSw8UMxQAeIqhlU4hDSr
         bMOw==
X-Gm-Message-State: AOAM533yMwb7PzR4xZhWbuYdCmYzSI+9CU9sN/3jq/TWiMFh2DHRzuvt
        7NFPf76Fg08CLRU6QJqC9w==
X-Google-Smtp-Source: ABdhPJyW4S0Ic5zGxvFgmna5a0fy2EDagMuNav85rX4OIYGZLIrUok5+XAS/lrttQvtGHYh80ZPRYw==
X-Received: by 2002:a05:6808:903:b0:2d4:8451:d651 with SMTP id w3-20020a056808090300b002d48451d651mr9173464oih.29.1646062017625;
        Mon, 28 Feb 2022 07:26:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c1-20020a056808138100b002d4b30ab04esm6534610oiw.32.2022.02.28.07.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 07:26:57 -0800 (PST)
Received: (nullmailer pid 1049704 invoked by uid 1000);
        Mon, 28 Feb 2022 15:26:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Potin Lai <potin.lai@quantatw.com>
Cc:     Patrick Williams <patrick@stwcx.xyz>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
In-Reply-To: <20220228103716.10774-3-potin.lai@quantatw.com>
References: <20220228103716.10774-1-potin.lai@quantatw.com> <20220228103716.10774-3-potin.lai@quantatw.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: hwmon: Add sample averaging properties for ADM1275
Date:   Mon, 28 Feb 2022 09:26:56 -0600
Message-Id: <1646062016.577370.1049703.nullmailer@robh.at.kernel.org>
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

On Mon, 28 Feb 2022 18:37:16 +0800, Potin Lai wrote:
> Add documentation of new properties for sample averaging in PMON_CONFIG
> register.
> 
> New properties:
> - adi,volt-curr-sample-average
> - adi,power-sample-average
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> 
> doc
> ---
>  .../bindings/hwmon/adi,adm1275.yaml           | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/hwmon/adi,adm1275.yaml:68:11: [warning] wrong indentation: expected 12 but found 10 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1598637

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

