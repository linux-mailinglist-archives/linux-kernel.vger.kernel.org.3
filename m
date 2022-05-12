Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF6F524836
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242107AbiELIro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiELIrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:47:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F40454F8E
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652345259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ezHtnkHFSmSnp4Ra5qJG3CnHU6zqF6Z+8VJf976ZCAw=;
        b=biwK0MJxBcA7Q2kId4bz69lEE1M9DPgzCY/34MqBsnXyenuJvnzmDS8eA29QczNVcmTMBD
        rbC+RyG3+aMA4gLxIP5kg8g4c6fZcBfPwLc7h4KmyjHTXgOqIL4SBp/6Po1xi/q1jsZSJ+
        fXHpxNe+KLyXNvsZgXEtt/z8QXHlynU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-bkbQ3UUCPLShnaplnM40Iw-1; Thu, 12 May 2022 04:47:37 -0400
X-MC-Unique: bkbQ3UUCPLShnaplnM40Iw-1
Received: by mail-wm1-f69.google.com with SMTP id s14-20020a05600c29ce00b00394611a8059so4090138wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ezHtnkHFSmSnp4Ra5qJG3CnHU6zqF6Z+8VJf976ZCAw=;
        b=tEVl4ascZ8HYCXn5NfpXFbvxOHSIUiUm57eOVX1mzhKmVE0ZTBAEqrazy9UrBPw6R+
         TycqhpnlbzMb1V9gzXFE5CMXVamgoz+zh6Nei4bYCnA+/z49OIBHEQP1ikenEoK/k66/
         snJwFK8kn0o2S3U7N8k6A8FyouJ1EvivINnCweW33SNxWYC7NtPkkFHgWjYxYTLC7Sux
         j4Z5fqeo6xFkj9xhzhTFvegW6J+lHelA+uY/Ha8Yij8xGhop9N3UsUJOwZGk4GlWb6JB
         ibWNA7ZfDTGGYx3Bcsl1a0kuOAexCTjhYs+FtW2WbfZXm4bUz1GYzevVRDLeT5JiQ1kO
         a0XQ==
X-Gm-Message-State: AOAM533vPxcmx1YElh/H589mycPiZZe/m9Dr4acfT+5sQ+QJ2ZHDoBNb
        nAzQxAyGEBumGP/pNO5ldFOGZfxyG8JruIVCgfnWHLgxHTTdTL5uOEqj2hF9AASWU0uQ648TKK5
        Xsh32gq5xsBc/7YdCDzJAtYmy
X-Received: by 2002:a05:6000:1843:b0:20c:57b2:472c with SMTP id c3-20020a056000184300b0020c57b2472cmr25923935wri.142.1652345256710;
        Thu, 12 May 2022 01:47:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxH4NRXiKJzWEh+1ly9sKXQ7EGmetg3l/XxolUOl+eJ/zUJw2GeFLWVgwMq/hSQUHDVhESJCQ==
X-Received: by 2002:a05:6000:1843:b0:20c:57b2:472c with SMTP id c3-20020a056000184300b0020c57b2472cmr25923921wri.142.1652345256525;
        Thu, 12 May 2022 01:47:36 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-113-89.dyn.eolo.it. [146.241.113.89])
        by smtp.gmail.com with ESMTPSA id j32-20020a05600c1c2000b00394832af31csm2248228wms.0.2022.05.12.01.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 01:47:36 -0700 (PDT)
Message-ID: <58c647040b4a9500c687f9a3dd3d8ca8fc1c4cbb.camel@redhat.com>
Subject: Re: [PATCH] ethernet/ti: delete if NULL check befort devm_kfree
From:   Paolo Abeni <pabeni@redhat.com>
To:     Bernard Zhao <zhaojunkui2008@126.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bernard Zhao <bernard@vivo.com>
Date:   Thu, 12 May 2022 10:47:35 +0200
In-Reply-To: <20220511072512.666863-1-zhaojunkui2008@126.com>
References: <20220511072512.666863-1-zhaojunkui2008@126.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-11 at 00:25 -0700, Bernard Zhao wrote:
> devm_kfree check the point, there is no need to check before
> devm_kfree call.
> This change is to cleanup the code a bit.
> 
> Signed-off-by: Bernard Zhao <zhaojunkui2008@126.com>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

The patch looks good, but the somewhat strange From: header is
confusing pw and you probably want to drop one of the SoB above, please
re-send, thanks!

Paolo

