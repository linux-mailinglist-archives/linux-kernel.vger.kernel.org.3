Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD1C52A0C3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 13:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiEQLxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 07:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345508AbiEQLxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 07:53:54 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945444BFFA;
        Tue, 17 May 2022 04:53:51 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D50712223E;
        Tue, 17 May 2022 13:53:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1652788428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4JeuNMnLUIShnOTplMHIItkUFZ+vv40zg13zfGeMbVk=;
        b=DHRtLB+2YaBGPstvOeUrFtQvhn4A7rl+u1zER46nke1bDMqdZuVVmcj4IHUpmfvOFrEHK+
        USraUAroiSjO552zPaZjX8CyTaEtK2xDQJ0Qk8JIVCPB6zSLWDJL1tL4u9bx5yVde04oXQ
        ffsFQV1BXCaXZ30nEwWRhKjLrqwbBfo=
From:   Michael Walle <michael@walle.cc>
To:     peda@axentia.se
Cc:     Manohar.Puri@microchip.com, UNGLinuxDriver@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        devicetree@vger.kernel.org, kavyasree.kotagiri@microchip.com,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, nicolas.ferre@microchip.com,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 4/4] mux: lan966: Add support for flexcom mux controller
Date:   Tue, 17 May 2022 13:53:27 +0200
Message-Id: <20220517115327.4139280-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <e43d766f-ec63-93d7-6b19-05b32579e6e3@axentia.se>
References: <e43d766f-ec63-93d7-6b19-05b32579e6e3@axentia.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> +struct mux_lan966x {
>
> Why is the file named lan966, but then everything inside lan966x?

So I was about to reply to the bindings but since that question
came up here, too, I'll do it here.

IMHO the name "lan966" is super confusing and if I followed it
correctly, it was just invented because the DT guys don't want to
have a wildcard in the compatibles. But LAN966 isn't a real product,
just LAN9662 and LAN9668 is.

I'd really prefer to have a consistent naming. I've said it once
[1], having "lan966" (over lan966x) feels like cheating and is even
worse, because everyone would assume there is a thing named LAN966.
lan966x might lead the reader to think twice what the 'x' means.

So I'd prefer to have lan966x in the documentation and the drivers
and just "microchip,lan9668" or "microchip,lan9662" in the
compatibles.

-michael

[1] https://lore.kernel.org/linux-devicetree/d18291ff8d81f03a58900935d92115f2@walle.cc/
