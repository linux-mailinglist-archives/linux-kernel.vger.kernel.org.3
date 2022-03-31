Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623724ED7A7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 12:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbiCaKO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 06:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiCaKOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 06:14:54 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6E81EECC;
        Thu, 31 Mar 2022 03:13:07 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p12-20020a05600c430c00b0038cbdf52227so1700011wme.2;
        Thu, 31 Mar 2022 03:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dKkMeptSr36K5MwCeZt80OcWRzRb8UQj5WuimYmARbo=;
        b=c10QXVAA0Dxut1I4GVKnE6PpwlNm0nURglIWMhhy1wcvOUIEJmH6LQPMS4+/m9NsM+
         O+8PZ2Py09DfMoTm4qXKMZ/tjQhrkBlfiF/ErHDRMUPPnlmZ/eSzuTG1V6v8BG/VyEhd
         z57tNNUuecaGNY88UTnbsv1gh3F/ZntaLP47gacjslesFqdl6wIwkC5usWzpYrWJAPI8
         my1EDtJOn5iNc2D3YdzLjXzjGZxKnOCPrzRIDGC92xb/LA8g+Kuz0zIOvN588l7AlEUD
         V99MVKVsr3zjmDomQt3p2uMAIN+pXCkggSQPjX/1JXBwj/CUVbHRB44ztrJptjto2MxY
         HroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKkMeptSr36K5MwCeZt80OcWRzRb8UQj5WuimYmARbo=;
        b=ckX1hQeMnVfQX6qGf3AHpRyLLh+Ef3O/dP+FuclM2W1Ube60CDMJqWcqwwAQHMFIcQ
         fBWJmyijpQdOwlEYgBaxXpJViwGd7aRoFJPiPy/Hsn8Iau+PFovgdRHXgBl/bRvwoB3E
         SjlFfTE+B3/wRxBgyn5bL2q1bLEV4bQbpGpabnITf0f40yuRKybfJlotM/jh4j4FhWA+
         1n9VgEIbIf2s+wNBG9oYYuekfQya8r/axS6iysvgUJUK5qcLH9vvP0kpTBV4sVr0lx3X
         Bd5pb2F4I5Xg6xL1SzVOM+jd5mOpuMpEmRh8MVkRB++qJzog/znJaFLCiboOKI+9fig7
         x2qA==
X-Gm-Message-State: AOAM530KrNp0/RzIq5QQojWAgfEMHDhbhF7X47iobqs3hb6uozl8foIt
        KHEWyILcg6ltFGmQR2EVDo7c2xbyOtE=
X-Google-Smtp-Source: ABdhPJw65pMOd/a/TkP+RPpEPUTYbErdPZV0+1TQOfGoel/Y4yrLicjLv1Mqe6jtdNx2Z1YhYacByA==
X-Received: by 2002:a05:600c:6001:b0:38c:6c43:4427 with SMTP id az1-20020a05600c600100b0038c6c434427mr4036846wmb.186.1648721585268;
        Thu, 31 Mar 2022 03:13:05 -0700 (PDT)
Received: from leap.localnet (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id t9-20020a05600c198900b0038cb8b38f9fsm7163875wmq.21.2022.03.31.03.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 03:13:03 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Wenchao Hao <haowenchao@huawei.com>, axboe@kernel.dk,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com,
        syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, linfeilong@huawei.com
Subject: Re: [PATCH] scsi: sd: call device_del() if device_add_disk() fails
Date:   Thu, 31 Mar 2022 12:13:01 +0200
Message-ID: <1722561.VLH7GnMWUR@leap>
In-Reply-To: <YkVwt4s+K0haRpbr@infradead.org>
References: <20220329154948.10350-1-fmdefrancesco@gmail.com> <10056508.nUPlyArG6x@leap> <YkVwt4s+K0haRpbr@infradead.org>
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

On gioved? 31 marzo 2022 11:13:27 CEST Christoph Hellwig wrote:
> 
> .. and then the cleanup patch would need the same logic.  But thinking
> about it I don't think we actually can do that due to the split
> unregistration.  So I take my suggestion back.
> 

If I understand correctly, after thinking about it some more, you decided 
to withdraw your own suggestion.

Dan had already approved this patch.

Therefore, I'll leave the patch as it is now and wait for someone to place
a "Reviewed-by" tag and Maintainers to merge (if, in the meantime, nobody 
else require further changes).

Thanks,

Fabio 



