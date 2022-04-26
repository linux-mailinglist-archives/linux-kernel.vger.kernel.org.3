Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B356510060
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351597AbiDZO2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346461AbiDZO2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:28:06 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FCC5A082
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:24:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l18so9797509ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vGi2xWo0glztPoHlb3pGflxD9oTprLjQ3hPK/vMNf9g=;
        b=hQ7W0BWcpUkQc/T8HXofDKebFeuGCBNPA5SZVDUfqR/Wgw7Qois8SYRnyk9WOoAHeu
         F/9jI9kUIifVKMlpQKopUdI/JZsUhYq/vQcqeQK4/nxr9MspWekGKFdgaWjZZsQVqxhu
         tmS+2B+y3iD7cVRg0aBWsQnviwtyJcRl60tsNuO09pmmr2LGiuSl+b9edYTc8nrargte
         ufPok664AcZ7cV+an88gvuWIEVSJMo3IR31ozD8FfRbz1dZEA5V21oxe1GZ9V7jSg/cU
         hgKUeLqYaG8JBRTtZFaqg06j5HFctbBkAB4mjjXcEmG4ci7ClXQz0YfqeQxhVk0uUDy0
         5fKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=vGi2xWo0glztPoHlb3pGflxD9oTprLjQ3hPK/vMNf9g=;
        b=GSHmb/ISu6xbuvwAAPJ7dkdlW7gYDu7WS5A+C/EcVuUoUNCuFZ5v8MB5dOvX4nIT4t
         nODLFujCVqI0v27lvT/O3mVQk2Ajh/0qqePgJljs0ptrMldVcyaWqb6O25Q2TDn6agIY
         nNyUEXxI42nqcuLGk5oD5WtNRZS/c5C9sQZSBQgHKnGkbRhS/AO+p5VvDFF8nlqLsvgN
         VdKt5Q5fItN0EAcTO4tRK7wvkoOcOoYCgAc3cWyjy54eQvsQ8yIf6E4DXOFjeUZZbG9G
         tOZRUTCVQMomzseRXqgIGi8MKdxcGpS3/ANo0UCG4KwuauVYM1Df3xa27cUpkr/co+qI
         /IKg==
X-Gm-Message-State: AOAM5315gXc6PCiXZlJXZ6v4qeqHkg4Qo/hn81FISRRvwSZatm34n+43
        tyUJ8GphKwOTGoeDQ/iyy1Y3vg==
X-Google-Smtp-Source: ABdhPJwqgfbj1kmKNaRApziMfN3y1y0mgZBxvHxiI0QR5TzVpevciWSnaiC3oLvOhLwmBH4Io+45bQ==
X-Received: by 2002:a17:907:86ab:b0:6e8:d60e:d6c3 with SMTP id qa43-20020a17090786ab00b006e8d60ed6c3mr21366841ejc.346.1650983095263;
        Tue, 26 Apr 2022 07:24:55 -0700 (PDT)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id l20-20020a1709062a9400b006ce71a88bf5sm4976128eje.183.2022.04.26.07.24.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Apr 2022 07:24:54 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH -next 00/11] support concurrent sync io for bfq on a
 specail occasion
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <20220413111216.npgrdzaubsvjsmy3@quack3.lan>
Date:   Tue, 26 Apr 2022 16:24:51 +0200
Cc:     Yu Kuai <yukuai3@huawei.com>, Tejun Heo <tj@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, cgroups@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yi.zhang@huawei.com
Content-Transfer-Encoding: 7bit
Message-Id: <7C91FB1F-0690-4D1C-A631-98236F6DC55F@linaro.org>
References: <20220305091205.4188398-1-yukuai3@huawei.com>
 <20220413111216.npgrdzaubsvjsmy3@quack3.lan>
To:     Jan Kara <jack@suse.cz>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 13 apr 2022, alle ore 13:12, Jan Kara <jack@suse.cz> ha scritto:
> 
> On Sat 05-03-22 17:11:54, Yu Kuai wrote:
>> Currently, bfq can't handle sync io concurrently as long as they
>> are not issued from root group. This is because
>> 'bfqd->num_groups_with_pending_reqs > 0' is always true in
>> bfq_asymmetric_scenario().
>> 
>> This patchset tries to support concurrent sync io if all the sync ios
>> are issued from the same cgroup:
>> 
>> 1) Count root_group into 'num_groups_with_pending_reqs', patch 1-5;
> 
> Seeing the complications and special casing for root_group I wonder: Won't
> we be better off to create fake bfq_sched_data in bfq_data and point
> root_group->sched_data there? AFAICS it would simplify the code
> considerably as root_group would be just another bfq_group, no need to
> special case it in various places, no games with bfqg->my_entity, etc.
> Paolo, do you see any problem with that?
> 

I do see the benefits.  My only concern is that then we also need to
check/change the places that rely on the assumption that we would
change.

Thanks,
Paolo

> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

