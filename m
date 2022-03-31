Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800824ED1A3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 04:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352517AbiCaCWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 22:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242424AbiCaCWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:22:03 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2875D66213;
        Wed, 30 Mar 2022 19:20:17 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id p8so20602852pfh.8;
        Wed, 30 Mar 2022 19:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pKxx+wpVz1LLUHIq7CMoPWM4WsNK0ilDi2hSr11bjwY=;
        b=Od66RLsiC/jtLcvMdNCf5vHNBpfUts/NTTT9y+BIRxkl0YDcEK5vId8H/ekGdCqpi8
         wtUKIWfRpwnRMHrzP7bHF9Ad7NzNaHZf8CYSVQb+TnqMsn6DPJUuF/Iun3grCW64yEU8
         1Ge+gJ7Hp8zHYm0otJ5mewDwgQe/ny4519XUgARbFvo1NqevuPE7fSGSlm5JLkURcu9r
         xoKV47HhT1dnYcwS7lrzP0VELNTqQYn1/w1K1hmTkwVJdJHwpU8Be6VL7aGtUx085D4d
         OjYikUmgQCa09WjYqBG+bUaK4XSN9RrrZAzDkWUTua/LbUfZ983LGXZcqdef/Sj5wWSv
         05ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pKxx+wpVz1LLUHIq7CMoPWM4WsNK0ilDi2hSr11bjwY=;
        b=BBdDYgFtgsjGTMGJwz4tNVHs/xNDmrYaAIMrpV37KHrgfVtZ6fih44rgvFh78tF30l
         A69YNfNRs6UUz3T/reO/34TjoA2+kRYWTL34QoIExU4PJsxGGsPgYLZUBE56NJ7KSUBS
         cBYBVIc7eIzW8PQcrjtm+dDztVIkQ1ITHKogDvMRe/xhebCXYwyjbUD1u6PDrNdDtLPv
         +WTiQ8XJv75qWKM2XOidZ9fii4CB6+Lnyls9WLR+mkMZL7xyfGOFDv3Y7IpR+h8Qy8os
         7gEUW3j7Nv8YrwkseFDzaDfamN5DZhITkwqOWrHrM/ZJOTcPwQuDdw8QGCe8fOv++g/6
         2WnQ==
X-Gm-Message-State: AOAM533MU1yfiemG4g1IbSaeOt66xDqg1erBLE9rUCMgrkTz8CWN9Qhw
        k7JHTuGheZgM3Zmo3ZBvd0BNDaXHyJyFwbiY
X-Google-Smtp-Source: ABdhPJxvtqKPvhiJ0GsRb8NzFloem2t7FjyuHXZFlPmcbg9ZEU9+4++k3/8CEjmiMns1OJKMnWPcbw==
X-Received: by 2002:a63:416:0:b0:386:66e:33d9 with SMTP id 22-20020a630416000000b00386066e33d9mr8859923pge.146.1648693216570;
        Wed, 30 Mar 2022 19:20:16 -0700 (PDT)
Received: from ubuntu.huawei.com ([119.3.119.18])
        by smtp.googlemail.com with ESMTPSA id ij17-20020a17090af81100b001c67c964d93sm9096255pjb.2.2022.03.30.19.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 19:20:16 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     viresh.kumar@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nm@ti.com,
        sboyd@kernel.org, vireshk@kernel.org, xiam0nd.tong@gmail.com
Subject: Re: [PATCH] opp: use list iterator only inside the loop
Date:   Thu, 31 Mar 2022 10:20:09 +0800
Message-Id: <20220331022009.28621-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220331021235.bhb4t2g43eva3c3s@vireshk-i7>
References: <20220331021235.bhb4t2g43eva3c3s@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On  Thu, 31 Mar 2022 07:42:35 +0530, Viresh Kumar wrote:

> Hi Xiaomeng,
> 
> On 31-03-22, 09:58, Xiaomeng Tong wrote:
> >     dev = new_dev->dev;
> 
> Why is this added here ?

Sorry for that. I will delete it in next patch.

> 
> > 
> > As discussed before,
> 
> Please remember that whatever you write here will go in the commit
> logs for ever and no one will ever know what you discussed and with
> whom.
> 
> This area should describe the problem at hand.
> 

ok, thank you for the suggestion.

> > we should avoid to use a list iterator variable
> > outside the loop which is considered harmful[1].
> > 
> > In this case, use a new variable 'iter' as the list iterator, while
> > use the old variable 'new_dev' as a dedicated pointer to point to the
> > found entry.
> > 
> > [1]:  https://lkml.org/lkml/2022/2/17/1032
> > 
> > Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> > ---
> >  drivers/opp/debugfs.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> > index 596c185b5dda..a4476985e4ce 100644
> > --- a/drivers/opp/debugfs.c
> > +++ b/drivers/opp/debugfs.c
> > @@ -187,14 +187,19 @@ void opp_debug_register(struct opp_device *opp_dev, struct opp_table *opp_table)
> >  static void opp_migrate_dentry(struct opp_device *opp_dev,
> >  			       struct opp_table *opp_table)
> >  {
> > -	struct opp_device *new_dev;
> > +	struct opp_device *new_dev = NULL, *iter;
> >  	const struct device *dev;
> >  	struct dentry *dentry;
> >  
> >  	/* Look for next opp-dev */
> > -	list_for_each_entry(new_dev, &opp_table->dev_list, node)
> > -		if (new_dev != opp_dev)
> > +	list_for_each_entry(iter, &opp_table->dev_list, node)
> > +		if (iter != opp_dev) {
> > +			new_dev = iter;
> >  			break;
> > +		}
> > +
> > +	if (!new_dev)
> 
> I will rather make this BUG_ON(!new_dev);
> 

Ok, i will take it.

> > +		return;
> >  
> >  	/* new_dev is guaranteed to be valid here */
> >  	dev = new_dev->dev;

--
Xiaomeng Tong
