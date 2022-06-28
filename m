Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A47A55D975
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245315AbiF1I7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232339AbiF1I7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:59:40 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D759FD1A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:59:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id t21so11441848pfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ktYB12CuOtgWAClcueyNRFthVvE6XX0IoFemGmYs/DY=;
        b=B1HxFpCwwpSl4XqvW/n+RUwu6bw2AeEOralrpD9fzeExPBm7O7fsn/BA/9LtbPyWpv
         aRUfU5URixo0ywnsoAtwRT3XpXftdHxQCp1W9kug8nfWeRHi640WORv3XFiIvxKFv3YC
         Hq5ao/Q0wjz7wECHzgSTlC9tQ8hsLk2QL8GtcTjEOSap/TWnrDnZ18AZ3HD0falKK2bt
         E0HS2SOIu5LzuC9f/gw7wlEmTlz2YB10TGg8U5wPDj9Q5EiUoy2OPY5+y1aT+rnNjrwS
         Zb28B5WLVfFHPfIAUjv96QbKaNifQfboe+qa4GbVi8NVLs3Oxj/3wGahm0+Dw5KhM2lg
         bhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ktYB12CuOtgWAClcueyNRFthVvE6XX0IoFemGmYs/DY=;
        b=tOIgtN7yVBsoPmlYxMEe/RgQp1LK93DqmkU5MxRrupp9PMZJVp65S44XaRMxMZyptU
         84fbzI62ou3kRbje2roTZHz6vnTPbbJB6+xyaIpWfcRG01+eIxgVrdIKy4sTs2f7IwXe
         /a2KNO9rKpzCWgWrqkyqMzNH4frm3KqcOvKnCbTznp30nkwX6lBZm8WluUK/JsCqMJd8
         egJoDxpeFZvUszZzkCZNiH0xwaCKlLIsTUEdr18CIP7urfKtoDju2CZK38N+HKAErlmv
         ozhji2bmJeCKXxRTpUW2Sh45lm+Hca8w6ZvQNfAu+P4UQjVekFcEvrx4iEomVTcdlrPk
         oPxA==
X-Gm-Message-State: AJIora9DcANLQfPTRb/EIPA5lLyvMyuBWNN2x4C6ww86T6n0aUm3en2x
        0WKmKd6RUJ+YjRdO8U7K/uU=
X-Google-Smtp-Source: AGRyM1upSNEzHTi1iLpzEIe2cHXueZ9JaPBa6cbzjkFs5lZecc5ENh3u2tX9kITzSfyra17TKioBIw==
X-Received: by 2002:a05:6a00:23c5:b0:525:7f37:b9a9 with SMTP id g5-20020a056a0023c500b005257f37b9a9mr2625443pfc.20.1656406778586;
        Tue, 28 Jun 2022 01:59:38 -0700 (PDT)
Received: from desktop-hypoxic.kamiya.io ([42.120.103.58])
        by smtp.gmail.com with ESMTPSA id x9-20020aa784c9000000b005251fc16ff8sm8736481pfn.220.2022.06.28.01.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 01:59:27 -0700 (PDT)
From:   Yangxi Xiang <xyangxi5@gmail.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        nick black <dankamongmen@gmail.com>
Subject: Re: [PATCH] vt: fix memory overlapping when deleting chars in the buffer
Date:   Tue, 28 Jun 2022 16:59:22 +0800
Message-Id: <20220628085922.22460-1-xyangxi5@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <466232ee-8d55-e33f-d2ca-e6b9fc0b8103@kernel.org>
References: <466232ee-8d55-e33f-d2ca-e6b9fc0b8103@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Both of them works, and I pick one of them.
>
> Sorry, I don't understand.

We can use both scr_memcpyw() and scr_memmovew() for the not
overlapping case (cp <= nr), which is more likely to happen.
In this case I keep using scr_memcpyw().

Yangxi Xiang
