Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E225A5B0F30
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiIGVdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiIGVdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:33:11 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CDE97ED1;
        Wed,  7 Sep 2022 14:33:10 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w8so24405532lft.12;
        Wed, 07 Sep 2022 14:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=/boyDA5h4t0gComCI2tC20XUM0bG0YFaenoe3Hg2wq4=;
        b=ns2/4Ix4A1RoqacdGtRk4V6LaiVNC7wMI1mqEdhORI19CX4QHtbGO6EBC64KNy4ReY
         5obskafRb9kiepRbuFxO8SBL0FK/dvBlhZnVyHCztAyRy+p+a0KgZuI1TQXqYRZh0eOX
         g8J+8Xa1jBD22G41n3gs/PgnaUCTpuQxtTJFokoqnYZqfOzyXlpyvnoq3hH+QfsHcLiK
         An0nL9US8/uT/k6u7bBuOMVcGnewnA/lJSKbeUfZHq3Nn+GEVU/XbjH0tTtqN9+EbJrg
         HDQYfe5PzRwh44qKxC3Gtz5rvjTRrBijRh8dPwaCnjESB0itfZJ6pspFHTyfSeBl7moZ
         +DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/boyDA5h4t0gComCI2tC20XUM0bG0YFaenoe3Hg2wq4=;
        b=uh8AGlfAbIO6OEXlWY5Q2GC/vZCW4uiQB7Xvjjv2ySrsjOE0KQuKQ4oR7vmhq1w/IK
         ONuiJbDZaTCPpnCiDgL4beZdylK6p3IAcfeVb7LHmPmhImYfkVGnfYqFPJ5kOxIdALnY
         rnt7m+7jyD2rJtKvokL6dVRDh8gAyyLdySjjIDjVY2B8lcOJ6NEN8wk1CHZdtjwePiLV
         j5IFKi7obbc40k8A1zX92Dsa3I0EfipoBU98knq9K1JIbAd2VLZrWHXsNEuvKqhl/cwM
         6IYGm7YpO8EDmhLCyQchdvD39AUHQ/8Nq3PUcSGapyyw/uGnbsoP6kUgS8RBjAgN/f4e
         gVOg==
X-Gm-Message-State: ACgBeo01p1JodKnD4lRmYGFKB5qaYLY5HDmOlze6fdiM/W/QtnuAuWxX
        hm60Yy/nIdhxJBhDadwkJQgmJKetVR6Zmw==
X-Google-Smtp-Source: AA6agR7VI3n4phO54PKU/Lcg6fXhkn4jQ+RsWYWhcbS/VmsuBbUwMkj9AmWPYPOmr6FGXVRoZjYg0w==
X-Received: by 2002:a19:ac45:0:b0:494:9978:178a with SMTP id r5-20020a19ac45000000b004949978178amr1599623lfc.505.1662586388639;
        Wed, 07 Sep 2022 14:33:08 -0700 (PDT)
Received: from abyss.localnet (2a01-115f-4107-5400-bd98-c56e-a036-7979.fa.ipv6.supernova.orange.pl. [2a01:115f:4107:5400:bd98:c56e:a036:7979])
        by smtp.gmail.com with ESMTPSA id q3-20020a056512210300b004946aef1814sm2032529lfr.137.2022.09.07.14.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 14:33:08 -0700 (PDT)
From:   Grzegorz =?utf-8?B?QWxpYm/FvGVr?= <grzegorz.alibozek@gmail.com>
To:     linux-usb@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, bastian@rieck.me, andrew.co@free.fr,
        meven29@gmail.com, pchernik@gmail.com, jorge.cep.mart@gmail.com,
        danielmorgan@disroot.org, bernie@codewiz.org,
        saipavanchitta1998@gmail.com, rubin@starset.net,
        maniette@gmail.com, nate@kde.org
Subject: Re: [RFC PATCH 0/2] usb: typec: ucsi: Check connection on resume
Date:   Wed, 07 Sep 2022 23:33:06 +0200
Message-ID: <4425011.LvFx2qVVIh@abyss>
In-Reply-To: <20220907115626.21976-1-heikki.krogerus@linux.intel.com>
References: <20220907115626.21976-1-heikki.krogerus@linux.intel.com>
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

Hi,
> Hi,
> 
> I'm sending these as an RFC first because I'm not done testing.
> 
> I made a small modification to my original proposal (in the bug
> report). Now also connection during suspend should be covered.
> 
> I would appreciate if you guys could test these again. If everything
> works, and the bug is fixed, let me know, and I'll add your Tested-by
> tags to the patches.
> 
> thanks,
> 
> Heikki Krogerus (2):
>   usb: typec: ucsi: Check the connection on resume
>   usb: typec: ucsi: acpi: Add PM hooks
> 
>  drivers/usb/typec/ucsi/ucsi.c      | 42 +++++++++++++++++++++---------
>  drivers/usb/typec/ucsi/ucsi_acpi.c | 15 +++++++++++
>  2 files changed, 44 insertions(+), 13 deletions(-)

I have tested this patch on Lenovo T14 Gen2i with ac adapter and everything 
looks good. I applied patch on linux 5.19.7.



