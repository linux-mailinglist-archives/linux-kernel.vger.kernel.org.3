Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC63055F0E9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 00:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiF1WK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 18:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiF1WKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 18:10:44 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C873702A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:10:42 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id i17so22065799qvo.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=33m4/oxqlSlv2TdYisiel6i+VYhVL9nUXzjTcRhRwvg=;
        b=TdvynhtUEMsgTVKqVYE2W87mH9/UWuO92yvUyUzz8ImSnats10x6x9eYhqcR8v4AjQ
         lvlvII+Gr1BtTNLIxdu9RUzr1KzuDQLcbwDf/M8rF8WKwJcax2YqwjoPYbjo1cjgbnyj
         hqUWMeha3Lfn1zVatlVwcQSilutgdL4KDj2hgwAkJ4SQNNvpvQfTRXCYMoBnoEDqG1Vp
         Vt/g1Xx1yhrsP+SpXE2cSolLc7hOx4qBOeGJKSCy1gIBpx1bJbPHBwSOrk2Z4VnddD+C
         D5hwCmtC9GkttDW4WY1LiY8fkzljoxl871ZVrJqywG6EDeUdb3uMWkOWGe91Pt++KHy1
         aPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=33m4/oxqlSlv2TdYisiel6i+VYhVL9nUXzjTcRhRwvg=;
        b=b/4rcUcDVUr7WyM2iONzErepbZQHgaOUbM6nS2lBxZqrprVhVxle4Et1gxrCwEE2Ut
         z5xRB3kFU9GqkTA8Da4IWDl8j8ggfFjhpdnemnQut6OXeQqfFqyvZBCGYKYE9F0Un8b1
         NCbAWF/0j2mQWAmpqu+zvFOVHRUzQcYE+2sDTnKbk1NI1X1e2nN5/LXEuYxHN5Z6F1kq
         frpmeo6UZLrvPfniHhO1I0dUtGdN/ux0nYcAWQdWe746pp6x27K1EQVKmkIte0hCAf4W
         fiK+PLkH+FicTGiK/rsEbfRPkM0UgTC8WZPnOJg3vmYzQrGHWaDHJinVVvZd9bVI9aco
         thyQ==
X-Gm-Message-State: AJIora9qOcRCk4u4FqRTNNMuOgYdt/filjQQikQLSoB0O0zlHS83BQof
        //phknNjkJ8h5uTvZqX8MWI=
X-Google-Smtp-Source: AGRyM1u8h2AoLdpIpVOgtQcUg6ZdQDiJ2y8SMmWuz52ekbJRihl/Sd7ZeldOGLyh4oEyUV/cy+vlFA==
X-Received: by 2002:a05:622a:14c7:b0:317:c977:2a94 with SMTP id u7-20020a05622a14c700b00317c9772a94mr146697qtx.591.1656454241067;
        Tue, 28 Jun 2022 15:10:41 -0700 (PDT)
Received: from spruce (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id j4-20020a05620a410400b006a6278a2b31sm478747qko.75.2022.06.28.15.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 15:10:40 -0700 (PDT)
Date:   Tue, 28 Jun 2022 18:10:38 -0400
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: checkpatch.pl bug for EXPORT_SYMBOL when struct initialization
 follows define
Message-ID: <Yrt8XgMe+mMIlHxM@spruce>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I believe I've found a bug in checkpatch.pl where an EXPORT_SYMBOL for
an initialized struct following a simple #define without an intervening
blank line falsely reports that EXPORT_SYMBOL doesn't follow the symbol
definition.  Here's an example:

	#define SOMETHING_ELSE 1
	struct blah foo = {
		.a = 1
	};
	EXPORT_SYMBOL(foo);

You can see from the debug print that the full statement has not been
identified.

	FOO A<+EXPORT_SYMBOL(foo);> stat<+      .a = 1
	 };> name<foo>

Unfortunately my perl skills were not sufficient to find a fix.

Thanks,
Joe
