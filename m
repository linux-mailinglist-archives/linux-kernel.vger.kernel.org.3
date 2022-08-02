Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54ED35884F5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 01:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiHBX4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 19:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbiHBX4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 19:56:09 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E78A188;
        Tue,  2 Aug 2022 16:55:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bq11so19021278lfb.5;
        Tue, 02 Aug 2022 16:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Nt0TDSwlCKQLmNvOm5+ynfZLhvKLFNXaYpsNsDkczQ0=;
        b=FdMZQwNU7yMBf/gxDKbYhopevWEDjw9H3czJxQ72vNyrCc0mHKedjpvqCnHfug7ft7
         iiHCoRaL8W68gjQwmOt/9EDutM4kEnNNDip1pRHJ48K3srvtsBNXs1gmEOh6nWcuDvob
         m2ciD4OYq3S0Zz6oItS3P0nmswl5A+QTH9bvkso6e1EbE4EVYDlqP6QaNE5W8N+MO2u5
         vQDn1U3l4EwaKBSbVb9/G7b24W9dYVhIGCPiQ+CX473gqqBByVP4iKjaf0nBdv9GIaUi
         bS8JRb90bSnyAOdScaWpLpnx9cPvfi79iPWR+0g3cDHjlxB6PG7fl98dZW+0ODdRLDU4
         xh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Nt0TDSwlCKQLmNvOm5+ynfZLhvKLFNXaYpsNsDkczQ0=;
        b=hJRyEQRyOVPz6eG2swX1DvKmlWWvHnzfyVW2fswpEtaLnwjNHEIQEl74tBGG+yq43l
         SW2mhwFJRm98PCCwxZqgEICUDUVQqvU/7i1C7cCDV71JLO2dLCP7y2HbH0uf2S682Opf
         CWnAHxbPSAzxG55wSgQFbYM/tO13JD3k6ILwogZSncceIlhyKLk82pdRa0giTzQCPRK0
         7K8zs/KqkGuyxrhw8WJYd/7h1KyGh08+hM3JNCcQ31XmCH1ZoUD+8QhbBf6zPIq7rIT7
         kWVRm7T075V4MsfdFeW5F16fJoByhggdq7TcMgdNAsbd7iYaX2woVMu+t1SmxL0COD+r
         MdMg==
X-Gm-Message-State: AJIora/mrj3Xzpg9uBUfdCwIO050kKDNkyVqagb4OI2JzoPj9nwd99ls
        HNUrGInxd76SCsOzrW733xR007St5Uspx3rTbl+2/qhXeg==
X-Google-Smtp-Source: AGRyM1vnVHr2wr+r445feTBSU2TALXymfeTEj9TR2JkdVCzrtZDVbcE6Uqk3gDapfXzUF97whqFXp0RzSeuD7r4c5Uo=
X-Received: by 2002:a19:dc4d:0:b0:489:63cb:20c7 with SMTP id
 f13-20020a19dc4d000000b0048963cb20c7mr7610842lfj.101.1659484541634; Tue, 02
 Aug 2022 16:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220802135423.1007-1-stanley.chu@mediatek.com>
 <20220802135423.1007-6-stanley.chu@mediatek.com> <39b2b9d6-8e17-5c9a-4e6e-a8d40f9ca4e0@acm.org>
In-Reply-To: <39b2b9d6-8e17-5c9a-4e6e-a8d40f9ca4e0@acm.org>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Wed, 3 Aug 2022 07:55:29 +0800
Message-ID: <CAGaU9a_BaA-Qj2s9M4y6ccbsOswic1n68j7f=+vDHa4O0z3daA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] scsi: ufs: ufs-medaitek: Support clk-scaling to
 optimize power consumption
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Stanley Chu <stanley.chu@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com,
        peter.wang@mediatek.com, chun-hung.wu@mediatek.com,
        alice.chao@mediatek.com, powen.kao@mediatek.com,
        mason.zhang@mediatek.com, qilin.tan@mediatek.com,
        lin.gui@mediatek.com, eddie.huang@mediatek.com,
        tun-yu.yu@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

On Wed, Aug 3, 2022 at 2:48 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 8/2/22 06:54, Stanley Chu wrote:
> >
>
> There is a typo in the subject of this patch: I think that ufs-medaitek
> should be changed into ufs-mediatek.
>

Thanks for the review. Will fix this in the next version.
