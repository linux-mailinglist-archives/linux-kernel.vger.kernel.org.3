Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2AB493724
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353030AbiASJWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240025AbiASJWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:22:39 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92860C061574;
        Wed, 19 Jan 2022 01:22:39 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id kl12so2225763qvb.5;
        Wed, 19 Jan 2022 01:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=se5ucCO0oyTzoXmYtox819ARwwa/m5alJiXr+YgpVhM=;
        b=I6uWg5Coo9QxsY3HVeB/+Ro1TUOk4pGTb7PU02YmHBHCPf/x3xgQGcI/b0qui/XT1D
         hsRVmXkOKDFf9RZJVhlJLrlBYtzjf3DQTi98P/1AD8WBhTIsK4G+Kzy3Yt+sxTqli0Ok
         MHDiCkpkRdk1f0q6FbLrr6RGMgIHT/1+i1mqKZf/RaTvJMQAR63yPUqbeL8P3TSPahVW
         xqTRp8JmYEGY8wwX/WYNmya/vOv+0Cn0otsSM7dGvb8Dru/lwZhUBLpR6ea8/3lMdMWF
         Ptrx3cF/mX3eRYgxujNn1BrzEtEMAQ09sQetUTaLiivHZRcdPCIwqu1OU33ymVcxjVyL
         +EKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=se5ucCO0oyTzoXmYtox819ARwwa/m5alJiXr+YgpVhM=;
        b=liMe/9ysz450xiFZgBoCdwX3IrtXYjfhX2JM//sEtA9YyYBZnxx7X7xPodysTjyFnF
         TF1g4vL6WrUMxNqj8bLJOVSOXja9zJuJeYsaS5VK21yK/uMRSUW4YD/qMbAj84Q90P1n
         n482ekU8j4aAYRBoP7hutzhaHqXaHbu7mDkU/fVdjnuOkq2tu8oBp9owkM5EwlhN7wPX
         ZzDUH8Qi19rZle0EBGWqA7hMdcIckHv3fEB26x0cG94svch0nMreVPKu/hCCDfdcZUYZ
         6OzkjQ2rwmvGMS7VB+KCNZO+XWuAti4xi1CeI/9E7vdgbncTEpToBos/53eKapCkqnmP
         UZKg==
X-Gm-Message-State: AOAM531034vL4k0ZRIJt0o2h4DxBhWO9KiSJBT1Vdshw7A4Fb3bMIQtm
        hqB4cNKddG3++1IviyI/REI=
X-Google-Smtp-Source: ABdhPJyAS0C27DUT1bw9th8Vlf/LhPLR3j4srG7dayF2ccrWuGNvtLUztesUKefrFffn0+ZPY7LlZA==
X-Received: by 2002:a05:6214:2a4d:: with SMTP id jf13mr25479853qvb.94.1642584158837;
        Wed, 19 Jan 2022 01:22:38 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id u6sm11956222qki.129.2022.01.19.01.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 01:22:38 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     damien.lemoal@opensource.wdc.com
Cc:     cgel.zte@gmail.com, chi.minghao@zte.com.cn, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, zealci@zte.com.cn
Subject: Re: [PATCH] drivers/scsi/csiostor: do not sleep with a spin lock held
Date:   Wed, 19 Jan 2022 09:22:33 +0000
Message-Id: <20220119092233.932270-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9f5428b2-4d36-29a1-ef1a-d544cec25bd7@opensource.wdc.com>
References: <9f5428b2-4d36-29a1-ef1a-d544cec25bd7@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, GFP_ATOMIC&__GFP_DIRECT_RECLAIM are indeed false
