Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15FCB58A033
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239725AbiHDSGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238831AbiHDSGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:06:33 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FA52CE0F;
        Thu,  4 Aug 2022 11:06:33 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id b18so365163qtq.13;
        Thu, 04 Aug 2022 11:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=HWKCx3kmVAAqVhchYS/gMZXU/DUuQ7NMhlnQNoYmSkY=;
        b=YFZqxKTyFHbW7OYV7m0atAGCm6jAFEYFtCvE9zrv6IthBfowNAkw/WkZLWGOmosT8o
         5DIhiTu6JErIcuVA0/VuR6nNwaV/tDf1ZUk+zkVlgpB4kNxeyN8MS0Ffc5mM3U8ui3A3
         H1/HZ9tOvmciZ/EJSttINByOo+LxlUBEbUw3V2IGA106y1/0Y01s41vPNIVPKJIBDk8+
         HCOOwfBN4Sx3LxN7eGplfFVuVG5NpmeQpn8KsV4Ujeu5+3Ti6EsDzM+dv1oVdI/W3nJq
         7r780z9ZS85HZaKkvEdyenYYVVvfvvDdne93Y0uWJvcr8SUfV6zTpoTDNv2ihWk3Ypsj
         2x2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=HWKCx3kmVAAqVhchYS/gMZXU/DUuQ7NMhlnQNoYmSkY=;
        b=ld66AofstutZ8WOb5yGhLVi1l6Kf+eXIoaoGqEaK0Rp+cdwHhWNIFDcEbCupO3Q0yI
         Le78L7ZsypzGU1cCFkbhEQjx/uU8NT2B1S4vWbMop+Kt0i5tM67W2Tww3QO07hvn3ETQ
         CB/Yy4p4fK2U4jN66qIdYfmBiatofAVH+nA2CSV0ittARYMjDccmjikkZuBwoJ9ZacKP
         fTjoHJZXDt8l7MxFrp/+j7w3uhW1CSZPNKlxMAxY3Vqrc8ssPuQFVDE1VRxgLX7UQ/JJ
         iEcnS35Y+Kaa6MEzUFC1uQbat4NvY+9yZMJgFrr7ffGhhNet8LJJ1JMpKlNlQ98PbfIJ
         /SoQ==
X-Gm-Message-State: ACgBeo3issIM9yIv2VoEboi+42Kvibb9NfyzWucfWJkyHSAQXo77P7e9
        PUVfaPpVZ/vWHqacZGSbLxY=
X-Google-Smtp-Source: AA6agR6BtWcgB3/MgVY4jjoUiY8LogQ+Z7be4ATWm+HVn1dvYDkTwbwL0BBB319SgImQLHR86wjDNQ==
X-Received: by 2002:a05:622a:296:b0:31f:5e7:272c with SMTP id z22-20020a05622a029600b0031f05e7272cmr2726560qtw.146.1659636392124;
        Thu, 04 Aug 2022 11:06:32 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a454500b006af50b6f10csm1180459qkp.61.2022.08.04.11.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:06:31 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com, kursad.oney@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ARM: dts: bcmbca: bcm63178: cosmetic change
Date:   Thu,  4 Aug 2022 11:06:28 -0700
Message-Id: <20220804180628.1339190-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801194448.29363-4-william.zhang@broadcom.com>
References: <20220801194448.29363-1-william.zhang@broadcom.com> <20220801194448.29363-4-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Aug 2022 12:44:48 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Add new line between dts node.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/fixes, thanks!
--
Florian
