Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA1751ADD4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377518AbiEDThY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352087AbiEDThW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:37:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8724C42D;
        Wed,  4 May 2022 12:33:45 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id z2so3227062ejj.3;
        Wed, 04 May 2022 12:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :cc:to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=EfORBn1IU5YLU6vM2lbHgc9xrAtSW0JJzEpjkXnN3Y4B1jVYnMZsrilE74yba/6U5T
         foNTCBSV4aOokszBa7PibzEXLnjScFYevmiylFPTcrK0G0mdFFO85zLbAPPZbWS/40s3
         IKk9oVafeGEn49zoSyxzMp0T3pl5iHAURlv4N60bM+BqKwE0nli6Bku9TeYyXQZ60/ni
         xtyCzYLlLnX9yfEsRrpEXxz6LCVjRkOJF2Gi5Oay+CcjWoqT0vPH8lGTpx1ILjKvE5Vm
         LGv7vUhuVrzoZGeLKsDX5wHNDwhDw+JCPRklh6KfKRtvy5Ys1qDPMU8W09vFcls99SqW
         b4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:cc:to;
        bh=4ht9G50SlYlr7BPTCuy+KjNotHQlLEXbSKghIYlF3TI=;
        b=ninSZgDk91npk7m/gYmIPLCfzOhRhHYuNvIwATzf5Pb6NXspbxbAbU5MgBjdRBPcff
         704/R6+AFqOTjts3mxHlmLY156DJOZpxI8MEnF2D+IBOi00rpQIuz/uqcGgg9s9gNR2f
         NRbTI6+UriwyILYXeOzT1SZT6lwAnBUdPnk5V01RnkI5bKGfllsmfIYcuNdzePMWltM3
         OT1dUakJGW37CjJgAsYRzFVWbKCqaE2k/afTQwJQWSlkOMyAOTyYytoZHfGciXT177yN
         Ju2hdgg6P7qDryMiIBo1pBL3cRJWQFWPFzrWtnDc5fTUjvLEG64ZA3eENFdemeT9MZOu
         j8Jg==
X-Gm-Message-State: AOAM5331uCDW8ezvQSi8OEkL+uTvGqNW3yR95I4q84+Z270+f3e5TF80
        ryLzTqXxtdTCaEf6hHuuDWKnjJbfwiqrunBJ
X-Google-Smtp-Source: ABdhPJwHcrtSQDlr+mZ7DmEAqZ68d81+yOhTo8ytpNTbKbcNHduv7VeyTXo7SzIxQjlFKNlEhAXEAQ==
X-Received: by 2002:a17:906:a05a:b0:6ef:a44d:2f46 with SMTP id bg26-20020a170906a05a00b006efa44d2f46mr21506417ejb.192.1651692824481;
        Wed, 04 May 2022 12:33:44 -0700 (PDT)
Received: from smtpclient.apple ([2a02:c7f:d28e:8500:75f8:3e84:fd90:ebc])
        by smtp.gmail.com with ESMTPSA id jl6-20020a17090775c600b006f3ef214e64sm5962053ejc.202.2022.05.04.12.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 12:33:43 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Jamie Cuthbert <jamiecuthbert0@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] hwmon: (sun4i-lradc) Add driver for LRADC found on Allwinner A13/A20 SoC
Date:   Wed, 4 May 2022 20:33:43 +0100
Message-Id: <FDBABC84-481C-4B0C-8475-131CA491DB4C@gmail.com>
Cc:     jdelvare@suse.com, jernej.skrabec@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux@roeck-us.net, samuel@sholland.org, wens@csie.org
To:     rz@fabmicro.ru
X-Mailer: iPhone Mail (19E258)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Sent from my iPhone
