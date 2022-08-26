Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EA95A289F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 15:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344024AbiHZNdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 09:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiHZNdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 09:33:01 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62506DC0A2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:33:00 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id y19so816584ilq.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 06:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=T7rDv8bfpF0NKm6b91fWsribvdEGLUAR/frSiVzPKqg=;
        b=oyPJVLCalZx8UQW/8LMEaZK4V8yP72pYIcmHOO1UEBZFE7chLsb5aYAuL7NnEd7TXk
         AUxBbIWAeGvWEaEYho8j47cQnBfeXT46er+lY3qqTDJEo3/NPDDT7kyh7AMNM28jIofj
         tq2bO/EKSllOUqbUbcZqqbuOliKir4GOS4VAx64E/PN6xFa8ojp35Db+jICGBZ5KpTJU
         Xb5gBYx8cDZp1aQkuHo/M01rtzX1qEk83dXE1lP2bOIQVtZi3Qbs+9czRzuBOEEY8ThF
         YtwCsbzMho2RIj+QBuLhwyNeDBm9HadH9O/KnO1LVLCMtdHXZUOAdEw35Zofh79Edq+R
         nvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=T7rDv8bfpF0NKm6b91fWsribvdEGLUAR/frSiVzPKqg=;
        b=Jg1uDIj7iztCqcQlu9ki34pGaSbCTs+AbHRnNE1O6z1MQTA3jiI8lSCbPqYPnAra3N
         /wHBtjOUGxmOj1lij5ffI8TYXECOlGio5Kk5liZ0/DuL56Mik3EWcwXnmRFnKST7jSKZ
         8d8OYTxK+JCZ9DoinnOk8TAFDwQ8caVyFhCKE5vuuDRzep3I7fhMiDQtkRDzO7EWb8PT
         QCwvg99SYTBNB32wX/mMO5gKmizKSkwbLH41JZodORl+/2RXwmBZxQpaY1ZuMNSk4Bo7
         jaSoOvQT0mT4whM4czNyb79Ma1YLWrKp/BQe+iyQS3zOoLcOAjRu48Q1rGuxwk0qcc2g
         oBxQ==
X-Gm-Message-State: ACgBeo2JU6xiuyAXwucEfDJyhNNbs75oGge/+hn1o1zUy6ZgymDlPPTN
        YiSz2r/iNhuDlwwMqmOcev45Pg==
X-Google-Smtp-Source: AA6agR48/u+wutZSalsjtPS42hEBqPHVA6Yh8DJzUfL5H55tIcHUdeX0NRjKsgeViJ3qKhUzaHL1TQ==
X-Received: by 2002:a05:6e02:12e7:b0:2ea:70fb:cc8a with SMTP id l7-20020a056e0212e700b002ea70fbcc8amr3526471iln.276.1661520779690;
        Fri, 26 Aug 2022 06:32:59 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e6-20020a6bf106000000b0067bcb28e036sm1090113iog.49.2022.08.26.06.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 06:32:58 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Liu Song <liusong@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <1661483653-27326-1-git-send-email-liusong@linux.alibaba.com>
References: <1661483653-27326-1-git-send-email-liusong@linux.alibaba.com>
Subject: Re: [RFC PATCH] sbitmap: remove unnecessary code in __sbitmap_queue_get_batch
Message-Id: <166152077799.21944.9327436933138809735.b4-ty@kernel.dk>
Date:   Fri, 26 Aug 2022 07:32:57 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.10.0-dev-65ba7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Aug 2022 11:14:13 +0800, Liu Song wrote:
> From: Liu Song <liusong@linux.alibaba.com>
> 
> If "nr + nr_tags <= map_depth", then the value of nr_tags will not be
> greater than map_depth, so no additional comparison is required.
> 
> 

Applied, thanks!

[1/1] sbitmap: remove unnecessary code in __sbitmap_queue_get_batch
      commit: ddbfc34fcf5d0bc33b006b90c580c56edeb31068

Best regards,
-- 
Jens Axboe


