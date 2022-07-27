Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4F9582052
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiG0Gpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiG0Go2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:44:28 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90F9402F0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:44:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so1258231pjl.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zlkKC3OHec9sDlNVcpUz/2shqFGmSlTGJLulV3pqeYU=;
        b=pVLvxlQPPqjF2aGuWDIGo7Ydyq7a/gemgzcuilGfY12LPGJjFqglBqbtT1g5nhS8aA
         mYV0QvhJuWk+Vkmh+0dwTHfit8bMrkszV1agiKXFk7uknPnuWPY24JlWBNXXyeEz9cft
         B3N72l6PtTTtYCNXvyUUIvedB32w00AkeNyIJjccD1CohzWYsPEAEd6us672sHRJShzg
         f3fuKzZbsMjHBU3XxUDyMOl2RqyzjvcgaUx7CgJjJvrNRYly70wOfAZuSgGPuAhGMMpO
         rZssBubUqmJ7fxCnGaK4MWDAal8xmomWTukvIVQGrtyyQDaFKsRFaP9bVUZNhj8Qlz6L
         RblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zlkKC3OHec9sDlNVcpUz/2shqFGmSlTGJLulV3pqeYU=;
        b=y0hxJRt2bOiyiXqaK/IjfwmJzXx9bIrg6L9BMOpSZ30MIMrg1Z9imSBrEnrez6E7ua
         ZNAl5Sa5lrEmJtj8R+CjzyKexUU2dvgM1G2dSAC6go3K7GUVfHIGVCfMKOedwE/xB/Fh
         jIfUgUjbhMMBnBpJuJqIEazEhuidgC4K8/HmYrUhwA4Qp+gkByT3WFihUwVWpNli4GSX
         +NjZbLxEt6aJiRUIazF7WsWC9NVokK9VSlwUR0cFxtQa2nqwk8p2gHVX6EViGqLxseC0
         y2FWwfHEv1NgsrKIgQaRubzCB8kpgcRrO8X7Sm2urJqna1C4rWgUk+zO9CatGKkh+MKB
         eeRg==
X-Gm-Message-State: AJIora/PyLowsx8omXEWuaM+53HDOFxedfIuRpr9K4IX1IwEBrCNvaUh
        DeqpZb3FGlz3JPN9WhCN0VmmMUgvHxniQ7sX
X-Google-Smtp-Source: AGRyM1vGjaXQr8ZigpSLqo6J2NUNqSrnl7GlIOiZDLH4bXTTcJB95C8i0jWJWO2bGAYx48WrSAcITg==
X-Received: by 2002:a17:902:9895:b0:16d:7d93:36fe with SMTP id s21-20020a170902989500b0016d7d9336femr11325410plp.48.1658904266491;
        Tue, 26 Jul 2022 23:44:26 -0700 (PDT)
Received: from localhost ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id i2-20020a170902c94200b0016d773aae60sm4417718pla.19.2022.07.26.23.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 23:44:26 -0700 (PDT)
Date:   Wed, 27 Jul 2022 14:44:22 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] hugetlbfs: remove unneeded hugetlbfs_ops forward
 declaration
Message-ID: <YuDexmVBXUip62Ur@FVFYT0MHHV2J.usts.net>
References: <20220726142918.51693-1-linmiaohe@huawei.com>
 <20220726142918.51693-3-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726142918.51693-3-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 10:29:15PM +0800, Miaohe Lin wrote:
> The forward declaration for hugetlbfs_ops is unnecessary. Remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
