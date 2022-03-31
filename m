Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450DF4ED932
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbiCaMEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbiCaMDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:03:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835721C16FD;
        Thu, 31 Mar 2022 05:00:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id g20so27870920edw.6;
        Thu, 31 Mar 2022 05:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eGk6hp1cjRwf/Z2iSyo20kNLHbQVMFCNuaMs0Rs1280=;
        b=AOVyRosQIc5R2N1+6CICHmtlfUo4QCpEVrmcWBz/JrGlqhg+6pPeHXqvhfRxrcRjws
         KzaTC02Hv8cOGF6HCXLwm55ukcSQnXmOTuq4e//KmC9j10bu9tLC3K7iXdPXmtS8iXRS
         j6U2H0SrKB8pxDTTBNdPwJOYSo2/yLfmycuzlqiVgadJgoRxOTGfxcB7vXawbXlTesfu
         aXmFod8GJDje4nrM8tT8Lofw8NN1bs5FYUx9DdCO6B2YhbTSaFLKGyoh3a/3vKcnZOd4
         v91RY1gBMoPU2tS50Bxcyhj676wVBR9ZJf6Kqz8tuSed+XuTxMQxGom4X1SuKu2NPxAH
         bnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eGk6hp1cjRwf/Z2iSyo20kNLHbQVMFCNuaMs0Rs1280=;
        b=Dnpze0s+1sUZW9hxocMh5oRNeebfv4qqQQMnHg2n897bk9vhLRKDkSqg+gFieDHuTo
         0zZT9c6oiXskufvf/WrMumF0y4xmQXl+FSLfFisRN46xK1Yfdq6SMVrRxj+FAvshTxFU
         ReRdqqCDqOPObXJQXm6KFuOz5omov3Ox5bmxxcQIpsgb/iE270+axVVX3bt+OdB6uyVw
         2pkkuogtkruSx3S92DmDCLB+zDKOWdFetPgMx44IddI3l2hukIrsRTX+I3L/XzgvdEPw
         1zs0aCMSl4l02x4XMPfjsCXJuUwk/PR93QBLew9gK6ZGzz6dSROD4WknZ702hjcxRyBh
         wGEA==
X-Gm-Message-State: AOAM532Bv2eyOrF13Gxr7NM4nCgi+drfXgK7TAtwYeeKKiFXojDV4ZeD
        FhC2hpQFrPQYpRST9yD/aiY=
X-Google-Smtp-Source: ABdhPJzfmp3R/snJpoz4JKLB8p6kVhzjLK3y15+yg2Msn43WCATfPtX/lADAdX1oJyKqIod0tml/Vw==
X-Received: by 2002:aa7:da85:0:b0:419:1e13:205c with SMTP id q5-20020aa7da85000000b004191e13205cmr16173995eds.363.1648728042064;
        Thu, 31 Mar 2022 05:00:42 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id j18-20020a170906535200b006e007fa9d0fsm9546074ejo.149.2022.03.31.05.00.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Mar 2022 05:00:41 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v2] block: use dedicated list iterator variable
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <a7b2fe8d-9967-2046-67a5-62d10e95a861@kernel.dk>
Date:   Thu, 31 Mar 2022 14:00:39 +0200
Cc:     linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: 7bit
Message-Id: <E262CAA9-1B49-4035-9181-28C6FFDBE21F@gmail.com>
References: <20220331091218.641532-1-jakobkoschel@gmail.com>
 <a7b2fe8d-9967-2046-67a5-62d10e95a861@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 31. Mar 2022, at 13:59, Jens Axboe <axboe@kernel.dk> wrote:
> 
> On 3/31/22 3:12 AM, Jakob Koschel wrote:
>> To move the list iterator variable into the list_for_each_entry_*()
>> macro in the future it should be avoided to use the list iterator
>> variable after the loop body.
>> 
>> To *never* use the list iterator variable after the loop it was
>> concluded to use a separate iterator variable instead of a
>> found boolean [1].
> 
> Not a huge fan of doing a helper for this single use, but I guess it
> does make the main function easier to code. So I guess that's fine. But
> can you move the call down where the result is checked?
> 
> qe = blk_lookup_qe_pair(head, q);
> if (!qe)
> 	return;
> 
> I prefer no distance between call and check, makes it easier to read. I
> can make the edit locally and note it in the commit message so you don't
> have to re-send it. Let me know, or just resend a v3.

I'm fine with you doing the change locally, thanks!

> 
> -- 
> Jens Axboe
> 

	Jakob
