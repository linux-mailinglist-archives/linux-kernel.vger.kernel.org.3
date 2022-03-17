Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDC34DC0B2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiCQIMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiCQIMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:12:44 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E937108193
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:11:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m12so5536087edc.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 01:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jtQWBLaDrBArWqmWot/qK2nwyh+bP+vnDzmbHrJsXek=;
        b=VxDQoKvXVFOlQ5TLzCU2fxc7EvaiNrogmhzQPCzOhaSPOp7ktvSUZ99ByEQmid/qxC
         XVNGRkUipWg1lcLOn5nXVFul/geyxG82EIKjflOGsklDVWS2OsTOsnMR+wOACm6lsybU
         ixx6fJxwlHv3bhsSZopP+LRaHLqI+B6ztmDoVkPfcBNn1dEwWa098gNJWFSDXY3sWsL9
         c14DL9RY6yvNiDFCWOMZDSFQGog4nHjO7GnmdMyEDm3AeB5Qr22c0MfmJp0ogtt84ILm
         nOdYeJRgchvNlaiMOLzf+fUnLWDKEZ4qGBLyhC1qubebSIvkgr20L5mcoVMv5218LMxB
         MUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jtQWBLaDrBArWqmWot/qK2nwyh+bP+vnDzmbHrJsXek=;
        b=KzayE+lrvMI2iCX+dCCprpwUjtGfjBSn00lCK7aYdExxbQc2b6k5nRzjaIXtBjyKKn
         dABVevSP67kZPA7iJea/VkXQ4+ks9h6m+HQgfRO/yY4jR79CTUI/RhZ2lhzptmZ8C/XT
         K+gMv+L8+XDMXdQIcLAGYSKM+H3IbHJRznfv/FxTeqHEniDkAMTkoTZ5lLYp+YhalR/u
         NPZCY5ejUSQhqaHjQ0Cudcx4Rt2FsS3jjBooqgre79b2RLMgz1RPud/PxANqrdU6mm7q
         ozJj/WwSu7SbFfK3IeKdd0qp6r27ozZBbEUDBDiZCyq4cMMe+6hJ5xPidfvOpOQmcA8/
         R4ew==
X-Gm-Message-State: AOAM5300UHJ5M/1zojA4mammnAWcAH4jRgPmUadXO+n7IeH+NzbiEp+E
        vsaL+DAnpZCUPcxh6OxBil9J0A==
X-Google-Smtp-Source: ABdhPJyB2yYg/gh58dKJRPw4PSASfvzsov2cAcREU9vG4rJaR7aZFopg2DCMD8VY8T43CyWuNoCglQ==
X-Received: by 2002:a05:6402:42c6:b0:416:541:4be1 with SMTP id i6-20020a05640242c600b0041605414be1mr3146063edc.238.1647504686456;
        Thu, 17 Mar 2022 01:11:26 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id i5-20020a05640242c500b00416701e9466sm2191421edc.26.2022.03.17.01.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 01:11:25 -0700 (PDT)
Date:   Thu, 17 Mar 2022 09:11:25 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Sun Shouxin <sunshouxin@chinatelecom.cn>
Cc:     j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        davem@davemloft.net, kuba@kernel.org, yoshfuji@linux-ipv6.org,
        dsahern@kernel.org, oliver@neukum.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, huyd12@chinatelecom.cn
Subject: Re: [PATCH v4] net:bonding:Add support for IPV6 RLB to balance-alb
 mode
Message-ID: <YjLtLdH9gmg7yaNl@nanopsycho>
References: <20220317061521.23985-1-sunshouxin@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317061521.23985-1-sunshouxin@chinatelecom.cn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Mar 17, 2022 at 07:15:21AM CET, sunshouxin@chinatelecom.cn wrote:
>This patch is implementing IPV6 RLB for balance-alb mode.
>
>Suggested-by: Hu Yadi <huyd12@chinatelecom.cn>
>Signed-off-by: Sun Shouxin <sunshouxin@chinatelecom.cn>


Could you please reply to my question I asked for v1:
Out of curiosity, what is exactly your usecase? I'm asking because
I don't see any good reason to use RLB/ALB modes. I have to be missing
something.

This is adding a lot of code in bonding that needs to be maintained.
However, if there is no particular need to add it, why would we?

Could you please spell out why exactly do you need this? I'm pretty sure
that in the end well find out, that you really don't need this at all.

Thanks!

