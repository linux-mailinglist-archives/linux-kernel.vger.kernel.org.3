Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA1DE510EA1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 04:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357126AbiD0CTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 22:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357113AbiD0CTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:19:33 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A680F40903;
        Tue, 26 Apr 2022 19:16:21 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id k12so230847qvc.4;
        Tue, 26 Apr 2022 19:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d1Feh6IaZR9DHKl42tREyqF5nX3nYCBXgtD+DtXyr3w=;
        b=GBZy9X7eS0lzdZRWjRuJrUBm/4KbNj5CLzL8Qm2mAai/GlTsjtyAjo+SaaJ7fZdMIf
         8FuoT7FSyc7mCQudoxXY7s4b5jwXsVM76zXy+Peh5RVVhPJuhJJXPke7WHq5GRT1Oq4k
         M3rDlxghRg21sFQhyKqmPOwuJ7+AIzHd2UaVEhgiyBbh/UrtXYoXpjcn086aj/E2nfsI
         FCSzsM1DQWkMiN+59onAI7EGtfgwKe9Q3p0o8uvK/87CpoUL99ncCMRVIq4YL/tRB3q+
         84cv85AHABLjF92tuHb/7mhfLn1wlTSW6+gzcqfHv+nH/s6l6BXS7AJaLYttAWqfEvvS
         91eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d1Feh6IaZR9DHKl42tREyqF5nX3nYCBXgtD+DtXyr3w=;
        b=mhapvSObgaP57iNO6GoCa5Yzf0BtJdhDGkVkeN39f9KbZFSYok8sspsD36I7Isy6u4
         uMVKOS3nN6h1Noun+1hjO75zzEFZTKgEV2XzTlbuz90RxWTwYlf7L4KClq7GPV54lvlz
         f36GZieH5B6uxyuCMPlAunDyCE3pLO5SCjfkGRjGKc0awhWKcncc55whA9hYMEvrCHvh
         yQJ3biafT+tuQstVlxBf4uHYaiO4/eyceA7QtPp6Ix6kAiGEIuHfDEIuyJwWLw+PVt+x
         D8R4bJqcODzwhpKoIcOfLPdNmoiuSI0+8xKwCPFpSfzvo80/s3fGfj2VacSdY3PmoIfW
         lufw==
X-Gm-Message-State: AOAM532DlMXFGugz4z9FjTZUez79vVDgCaDhUNzYPKiihltRgKkwzMnA
        uS1TfPfpR7s+DIsrjfhaZS0=
X-Google-Smtp-Source: ABdhPJz/IY28MzEl1Bf7c2ZXR7ZuSlFP9dZ72dnGO8sglPz+kVSvebWF0aRR8wm/Zznu2fA35HDMPg==
X-Received: by 2002:a05:6214:d0e:b0:456:4bf3:bb01 with SMTP id 14-20020a0562140d0e00b004564bf3bb01mr2958615qvh.61.1651025780885;
        Tue, 26 Apr 2022 19:16:20 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x10-20020a37630a000000b0069ecbe5dd32sm7223512qkb.130.2022.04.26.19.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 19:16:19 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     martin.petersen@oracle.com
Cc:     cgel.zte@gmail.com, dick.kennedy@broadcom.com,
        james.smart@broadcom.com, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        lv.ruyi@zte.com.cn
Subject: Re: [PATCH] scsi: lpfc: fix error check return value of debugfs_create_file()
Date:   Wed, 27 Apr 2022 02:16:14 +0000
Message-Id: <20220427021614.3841074-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <yq1v8uwro3h.fsf@ca-mkp.ca.oracle.com>
References: <yq1v8uwro3h.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So sorry, please ignore this patch.
Andrew pointed that we shouldn't check return value of debugfs_.
https://lore.kernel.org/all/Yl8v6OcArfqmVYj%2F@lunn.ch/

Thanks
Ruyi
