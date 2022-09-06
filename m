Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384B65ADDD9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbiIFDPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIFDPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:15:33 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C7B22BE4;
        Mon,  5 Sep 2022 20:15:32 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id z187so10050954pfb.12;
        Mon, 05 Sep 2022 20:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2Cv4J+G1ogeuhW2nYiMPfNrTRhf6xVCDkRcJYgEDOdo=;
        b=RPxZo+YsQb6XwjGWPcxzjVJSos/O53ZGOILrimS02m6F670i9ysff+OX6eOjWZqUKF
         kB9qKf3w2fGJ/6EBg+fogISllEmQ5S9DuNQ2ZQlYxvlRtaMKC3lsFb4qk2XCNkQcAR7f
         pZTesvWgOQbM29Me0oakWTpptZHxRYEHV4CbODiBdIKAQPIuIy34VW2C8v1sd+64gKWt
         YPvkBXlesFL2qPJdCzprNYsEAcdY23L9noBBPJemNg71shyh9VSzsS++SJdtDjHZ4O2V
         ZyfXPxJiA1WhANM2OjAYmL7Agwz6aC3cd+9RobBU/QJG/cMVB0+TLJD9UIFj+jg3Hq32
         8dPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2Cv4J+G1ogeuhW2nYiMPfNrTRhf6xVCDkRcJYgEDOdo=;
        b=BAPGCBur5B1Y1TeEiVvdM/StyaPZhnrg864JtVjWkoUip6VHH8TqPBcDyZ3TNenVub
         iVBX2UYV1jGQdIr+OtIdjRnzVVL67BVvVsfLTpmpvqYFL2iRRqBqrJ5XAXFSO2mowGNO
         gPRN7+gXbGe7t/Li7SW9cS8g3Cgt93EjX7G3vghFhdpTS1f0ZZHdh9W8pKcEB/Dxyv71
         9d5DEaQF5h1Bd+ZcC+jIVPFQ09dMsc5iUxdEt5smlxTSddZUU5k6h6mZ5Oj0pJE8rcVX
         qhbRFpZJRGtRm9kvgNy2840mPAWTyymJ7Z1dEJ5CtzJvSgCMYjVyTB9P6Zx5qxM4C3Kk
         PmtA==
X-Gm-Message-State: ACgBeo2esZn0R/9ttq2TEX78bBRPVJel9hLDZAeZhyUUeKVrAIETUvDy
        hgh/bm6z7Ci3rrx/c8bdS3o=
X-Google-Smtp-Source: AA6agR59Zl9XsjGYaA4xg8qC96Keihi4AwL8NlIKwkoOLV6Y1fdv9933OpmqptlzVYdQqPnKnvvWfw==
X-Received: by 2002:aa7:8b44:0:b0:537:a35d:3c11 with SMTP id i4-20020aa78b44000000b00537a35d3c11mr52527144pfd.76.1662434132005;
        Mon, 05 Sep 2022 20:15:32 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:1190:fbfa:ae95:111c])
        by smtp.gmail.com with ESMTPSA id s17-20020a635251000000b0041d628dde58sm7303516pgl.30.2022.09.05.20.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 20:15:31 -0700 (PDT)
Date:   Mon, 5 Sep 2022 20:15:28 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/5] dt-bindings: input: touchscreen: stmpe: Remove
 node name requirement
Message-ID: <Yxa7UCcheX5M/XKY@google.com>
References: <20220712163345.445811-1-francesco.dolcini@toradex.com>
 <20220712163345.445811-6-francesco.dolcini@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712163345.445811-6-francesco.dolcini@toradex.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 06:33:45PM +0200, Francesco Dolcini wrote:
> STMPE driver does not require a specific node name anymore, only the
> compatible is checked, update binding according to this.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied, thank you.

-- 
Dmitry
