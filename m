Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A52A55CD52
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbiF0LEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 07:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbiF0LE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:04:29 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DB96467
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:04:28 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id c6-20020a17090abf0600b001eee794a478so1382586pjs.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wcbJGzeACf4gbqmMxJfqxYk8w6znOqhP2rxQLvNcAw4=;
        b=SSmTcnHi6fs8Y/1bdABOrO9DsUKpQSFvVZwr+VCopTZ+K7SuPwfTsAUFd5KrDj4ZCK
         56/wuQB3ONfEf/AONXJPbTgbPTkGRfOv6UyzdsSftu1++ryKJOnfpMzbsGfr4KnQFDTK
         JO+a0NkrNxcnLB9M4R1UPOgh/1K5nHlQBIP2v5FJJkS4yCtfLHWkX/a/2wG3aDaCM0lm
         saFFilwXLP9W7gkHPqnspu/VWVGCouzYf+3UxW4Stu9GgBu+yFFfd/nSLPhgFRWPQTtM
         w4bOo7QhaAT0U+Iw4WUKhGvI4Z00hBg50omveudZgQBLlVKa1uvmm9kYw/2buEQitdtg
         OsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wcbJGzeACf4gbqmMxJfqxYk8w6znOqhP2rxQLvNcAw4=;
        b=TQV4Ed4dM5Gj7DLu06Iv7YIZpwUiwbEQg1IAavWQlkFAGnuCnEG8EAwEy9SDYnc9A/
         9zLyC6mK25jinFV9z6xNU2ouB7aAYa9lUCenWuj1Ke6yUcO8eQu6aRGQ3BLwkrVoY7Ve
         mY+oWw5kgfkivz+1KgTlnL7aGxiaudaGhJvT9hECOpcz9iX3Pdd96P2H9iPLsrSazLSR
         WueftzDwKtomU0UWyBQTDTBPo9gFcQHFOsYvQsXtq+k2nd6UDyc/U4zXngcgggQfgLOg
         Op3TbobfVtyGy2mrwqVHFyo0xITgQMHkwFOp/2glmAjNlZjlL2KK06nu1U89AwWyyxlj
         L4jQ==
X-Gm-Message-State: AJIora896MWJqqnKqElA+DW/IhV8dioepDviI1MO/t002Hw5yFUzQaaz
        TxaE+OElM9ExdcJjyZ2tJuFyrgHjA7fSNRyL2Do=
X-Google-Smtp-Source: AGRyM1tNvur3C/LUtQaHySirZf5UeS1HI+kX/FmUBWooB7Uu8TuugUQKPMJtY029DAYnBng/+kt0QQ==
X-Received: by 2002:a17:90b:3143:b0:1ec:be03:e0a5 with SMTP id ip3-20020a17090b314300b001ecbe03e0a5mr15631699pjb.30.1656327868145;
        Mon, 27 Jun 2022 04:04:28 -0700 (PDT)
Received: from desktop-hypoxic.kamiya.io ([42.120.103.58])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056a00331000b00518764d09cdsm7002678pfb.164.2022.06.27.04.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 04:04:26 -0700 (PDT)
From:   Yangxi Xiang <xyangxi5@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        nick black <dankamongmen@gmail.com>
Subject: Re: [PATCH] vt: fix memory overlapping when deleting chars in the buffer
Date:   Mon, 27 Jun 2022 19:04:17 +0800
Message-Id: <20220627110417.27648-1-xyangxi5@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YrmKvSFSvPpT7Q3O@kroah.com>
References: <YrmKvSFSvPpT7Q3O@kroah.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What commit does this fix?  how was this tested?

This bug is triggered by running a dynamic analysis on the kernel,
with the help of sanitizer to observe this bug. This memory
overlapping copy can cause data corruption when scr_memcpyw is
optimized to memcpy because memcpy does not ensure its behavior if
the destination buffer overlaps with the source buffer.

Yangxi Xiang
