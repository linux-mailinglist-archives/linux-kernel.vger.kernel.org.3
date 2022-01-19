Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0674936AD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352745AbiASI6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352672AbiASI6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:58:01 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9665C061574;
        Wed, 19 Jan 2022 00:58:00 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id 15so2140979qvp.12;
        Wed, 19 Jan 2022 00:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e8CM8vL7IeKKocsFcVqBMXB4KyHFYckrrU1Cwzj5xcc=;
        b=ALhxvuyFi32CZ+xGMu+5QkO3CE+5MxLqvFCQQdVQq8D3+qRkrCmFYtObCLIqJk4Y+M
         mHvMuQmXoqAE0pI5SBIWY05+4PUzBqcVvMTtq/94kpzzhYts++fu/T70UxRhffEoDqK2
         Pc+J9S7Oqlxx7vGYEoQOhPa4eXAuV1Ho7Y1FZLbTJjA4JR2QKqB5WG9pnXk/u/x/MS5M
         f006J/vYF1VyQP+Ehcho+IpUUaR7vw0JbHDLaipyhkUVwcOREHYUwlplfiRAzdS/6N9J
         ARL6uN99BzvsNGkBHexZMB8NXArhFiF5hFEhGPFk43dUboPYclqMVvxZyv/KWjzmuRFw
         qvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e8CM8vL7IeKKocsFcVqBMXB4KyHFYckrrU1Cwzj5xcc=;
        b=yMxNYIwsZkfqCOHKoUikN/fSojsetAMioGrkoNLDNmDI2ol3hhLA5sfFBtGVYBj7e7
         4kpxdaeVNOx2/5VpJbhxQlDJhRbU2cYbeueggPcqJXkGo9aohXlwaQ7jq4CECJytsZho
         9skINv+SwdMp+YHpUsIrOc5SoV7O8AIW+WBnxZ1cnpzzb5m/1Fyut/GKYJxTLCNRXxDD
         oD9VBVJrQtlhRQFUyFEP6YGofGxRQ3YBLBrMjOWNwZaBhXMMIsuQYIGyVbrBudWFdlkr
         Y2Wo8RXzTS2Ed2erdOWqILNrmCKX5b5tWM2SLQI5K2iCtaBpwat45KPQdpbREk53rcGw
         W5gA==
X-Gm-Message-State: AOAM532Jxt/Ucpii6XIEqo3qbTUdjStJoXt0Z1TkigZ7KkrSqw6OkhvK
        91+mxIvDNQHhLGSe4RuA5leR3RU/DF4=
X-Google-Smtp-Source: ABdhPJyBsZxLNGx5ifM6ptHJEm9aIsSh4FVl980QBTtJVvsfL0gknbjE0lN35Zbci5EP4D/3e//J/Q==
X-Received: by 2002:ad4:4ea2:: with SMTP id ed2mr26943878qvb.128.1642582680042;
        Wed, 19 Jan 2022 00:58:00 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h21sm2455258qko.89.2022.01.19.00.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 00:57:59 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     damien.lemoal@opensource.wdc.com
Cc:     cgel.zte@gmail.com, chi.minghao@zte.com.cn, jejb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, zealci@zte.com.cn
Subject: Re: [PATCH] drivers/scsi/csiostor: do not sleep with a spin lock held
Date:   Wed, 19 Jan 2022 08:57:54 +0000
Message-Id: <20220119085754.932168-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <f68657d6-027c-c842-ce35-5524cd782c7e@opensource.wdc.com>
References: <f68657d6-027c-c842-ce35-5524cd782c7e@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The might_sleep_if(gfp_mask & __GFP_DIRECT_RECLAIM) in the 
mempool_alloc function uses __GFP_DIRECT_RECLAIM.
