Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81074EDE7C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbiCaQQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239681AbiCaQQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:16:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFC055201;
        Thu, 31 Mar 2022 09:14:32 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bg10so385530ejb.4;
        Thu, 31 Mar 2022 09:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FcCfLyzsYqQGsFb8akFbb6JZWG/9vXgcMF8J+x5RgTo=;
        b=KNVfSswHBmhK2iu1F1kOKQ3KNCpbNu/Ugef2TxvfwjloYZ3/DTFQMw5K8b91+zBaa1
         +NR35BCwAd3B617BAuEReAFzyos00j7whUnx+kmcFquxjPPOkgegGrM2mv3Q3p0EI0Ty
         pxYBhJgkZf0KT4UWuq/eRZiq/PVUFzA9dR+kL87L3Sb2XgrrcDd4jMev/C6i+RJagtEc
         2aYeIyufTPHaQ9rKJuNSMcPbgXW0MfbutlnzYCoiGiutzWqkEO63R8Bf7RCSd/B3Q8Ui
         QeQw82JngZa9PnCbfpElTirQ8d4W3uilTrQ6w1ajLcitEs9HT8CZiMOt87Vnv2p76g/s
         wJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FcCfLyzsYqQGsFb8akFbb6JZWG/9vXgcMF8J+x5RgTo=;
        b=UE1ibcJusrLW1ikjmCCTGEN3izduWvjf+VE6RcsH4fO5uL1z3CXFSDgr619/zc9kDE
         qIXVy/FUU0/Bqr6zFXUSSvbQWNZbTM8F7xeKgbhmqPcvtZNJ8uJmxijlZvo/3Go3EsSf
         Wts/+TjFXqBErax9R6wZWE3/UdaIR3j6ETcSZGypATcWwbSc9E+W6glGZVB1aNbLZMPK
         aQ8lp/pw6Eswi0pJi7oW5jQMZpVnKso9JziDNF2BiO5C2pzPHa8ouVxFEQAgJYu1azG2
         gFCG2m/970MU9024iZXwtXcSjIr/SyYKbxtyOykuot2bzu1IBZ7HskfxwfZVbdNDXO2f
         FVzQ==
X-Gm-Message-State: AOAM5332xj2qgR4Rju9XFI0xQo6Jxj8FvKTKgs51ovIbKwnvUm8lwXcy
        GbqQY2CMmnksDT1NFNo2I2w=
X-Google-Smtp-Source: ABdhPJxrFeCrlrgYsId4lWZdjzNbs1gNXB+bHQsamw/8iBBZbKjMSEzvaieenk1/1kbxHBO64XBPnQ==
X-Received: by 2002:a17:906:58d3:b0:6da:bdb2:2727 with SMTP id e19-20020a17090658d300b006dabdb22727mr5604700ejs.549.1648743270654;
        Thu, 31 Mar 2022 09:14:30 -0700 (PDT)
Received: from leap.localnet (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id hp12-20020a1709073e0c00b006e02924bf20sm9606044ejc.117.2022.03.31.09.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 09:14:29 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Wenchao Hao <haowenchao@huawei.com>,
        syzkaller-bugs@googlegroups.com,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     axboe@kernel.dk, jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com,
        syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, linfeilong@huawei.com
Subject: Re: [PATCH] scsi: sd: call device_del() if device_add_disk() fails
Date:   Thu, 31 Mar 2022 18:14:27 +0200
Message-ID: <1787706.atdPhlSkOF@leap>
In-Reply-To: <20220331134210.GF12805@kadam>
References: <20220329154948.10350-1-fmdefrancesco@gmail.com> <fdebdbd3-575b-b30e-d37f-dcc6d53a4f53@huawei.com> <20220331134210.GF12805@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved? 31 marzo 2022 15:42:10 CEST Dan Carpenter wrote:
> Wenchao Hao, what you're saying makes a lot of sense but it raises a lot
> of questions in turn.
> 
> Fabio, did you test your patch?

Yes, I did, Dan. I tested it the usual way with the "#syz test:" command.
Obviously I have not the hardware to test code on it.

Therefore, the messages that say "Syzbot tested the patch and it didn't
trigger any issue" is all that I can know about the code being good or not.
This is the criterion I've always used before sending patches for Syzbot's
reports.

However, my knowledge of these subsystems and the API that are related to 
this bug were very little, but now I can say that during the last couple of 
days it has improved to the point where I can affirm that Wenchao's patch
seems to me to be the only correct solution.

Thanks for all the help you and the the other developers provided. It was
invaluable for a better understanding of this matter.

Regards,

Fabio M. De Francesco


