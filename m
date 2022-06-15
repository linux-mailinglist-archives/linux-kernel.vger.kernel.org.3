Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2280F54C1B4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351979AbiFOGNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbiFOGNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:13:04 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7017FF02
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 23:13:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so1080124pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 23:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hnoGBQrPK85JCgl7rQ6imQVPKzB/FybzwpvvNmXqIKY=;
        b=WLMMRgsXjHgKczW//3IeInWXQPBfsmbj+BXYrzWq92EClweHfYIR7eZ6NbuyFl62/Y
         6oRSnst+XAYUKcSaRqCmUnV0H5e5WH+cePk+Q5HY5pD9eWTZwE+sATWal8X03i8LUTTh
         oimN8v4xKvy6HnJLNYVloGbg229q5KZJTh3cCR5M2FeP0Y02AAJBf6AGfiazK0vjFoqe
         i5dxA6h83+ADSomF53F88KjY+ITVcB6z5GJVz+Sh5Fn1AM1eID8fv3QlEnWGKtcrm/Lx
         FQkQzd7PNbiXvjQP5J8XfdiDdQDTQHQ/FwiD2vupF0AAb0VrFGPCak4vsOlXd34xjm+p
         eHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hnoGBQrPK85JCgl7rQ6imQVPKzB/FybzwpvvNmXqIKY=;
        b=KXAqX1kZT9wjU7vsdI8sBlPkdHusQj7wtMo/6/+tBok/va1iKthPVk0+Xsc955SsC+
         FwVid58vGG42NPkEZxiKRxnteohvcNcPcnpyrpaPDda2VXHQa5dsheFOEPpNyxk4Wuek
         //dW6TmlN+FoLsS3Io1KBwv77XQCE5kpRoIT9738GisnD1O9k4KMKEDYC0JJdp2zHCai
         O0dWOSua3RxpF0r+vcmSt6meEZ59h+WqDRvKXTPVxvk+CZH1mVkQc4mY0tSGqW2OI0Z3
         6X6NJ0uxOaBVgYCJ7OsUnv806+15lZqgDkrF5AdQd4g/MNr2rwyuiIdoPFgdDvmfJfjw
         5nQQ==
X-Gm-Message-State: AJIora+lBIg53vHYo88xlZ6n3I4gD2w3ofegXQ3zFYp8RMdnyPqNzKxh
        4HAvYZvAhG3iFVReVuAG15k=
X-Google-Smtp-Source: AGRyM1su7WkTDtdDZg5ySULMFczN8ZxQyWjvbpgoTWXXpB5Fiv23RY6ojTEsW1X5b5BZFxZ0YtrC1A==
X-Received: by 2002:a17:902:b689:b0:167:8b69:d1a7 with SMTP id c9-20020a170902b68900b001678b69d1a7mr7654020pls.156.1655273579783;
        Tue, 14 Jun 2022 23:12:59 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:7e4d])
        by smtp.gmail.com with ESMTPSA id w62-20020a628241000000b0051bfd13809fsm8808247pfd.119.2022.06.14.23.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 23:12:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 14 Jun 2022 20:12:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/4] kernfs: make ->attr.open RCU protected.
Message-ID: <Yql4aerFAHyp7ymB@slm.duckdns.org>
References: <20220615021059.862643-1-imran.f.khan@oracle.com>
 <20220615021059.862643-2-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615021059.862643-2-imran.f.khan@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 12:10:56PM +1000, Imran Khan wrote:
> After removal of kernfs_open_node->refcnt in the previous patch,
> kernfs_open_node_lock can be removed as well by making ->attr.open
> RCU protected. kernfs_put_open_node can delegate freeing to ->attr.open
> to RCU and other readers of ->attr.open can do so under rcu_read_(un)lock.
> 
> Suggested by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
