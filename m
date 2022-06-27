Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2853155C852
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239072AbiF0LxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 07:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238467AbiF0Lsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:48:30 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747A8101CD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:41:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g20-20020a17090a579400b001ed52939d72so3703928pji.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Te7Bn8Ps7JLUBbyJF7xQc/CqErZW/fxCMAa/7Pn2yJM=;
        b=qr4/FdoUOLjao3iROoOoGGqQLYxyZk8N4KJeqcyLsA/aLFlDP6ADm5eaypCcTYBSPk
         GcR+tSWPRyMynemMo89OuGlPYzYpgQIHwbmoyJaRizq6YzIOsAuY+bM2Wpybp9byYCmN
         +wNEEA5+2h5HYgBSBLlNI94gyV3xriVzK/Nn9y2v5RtzU8sUu02OS1wByd8UypL52h3v
         dhJ+N+/WL1OqQwhpFa+NOYZjGSWAs5q/5iXcyDb07X8QqV+Vqe83pmqp65flZ7qD0k3L
         gUZocr93jSt/REJ8P7inp/EIoXZx8zAjRt4RHyT4rRZXyK1SuSaVkqIkuVzYcfn2pT7n
         Ksow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Te7Bn8Ps7JLUBbyJF7xQc/CqErZW/fxCMAa/7Pn2yJM=;
        b=jNFCZ7NwzIfD6wHcDofLteyQgMst59ZeXkctxoVgehWv3TaNJxpq117QLn5CWD9MYh
         CTJxetPPdh/ilt9JebaeCVK2jf+DrduiPxpQRUjIVJkbJNbjS10OTmEZIDe2Ae08VtPE
         CCqF27QCtGxNvs694ldTlKlSNqyMHi6gl0uwOT9zJ8o/5Qde9qQ7qSUp1BZv2bJsgaE9
         nREx99GdKhZENN6YlMKneln78kbxhdZKe5z60g2sl9aUfrdAdwWZlvzwLehE/lG/+w/T
         kngwoPVkXgrmHmT1JZdTXvB8GRtW+10iBPmaS9tkCUi1Ai4oEq9U/8ttkC2QV7iZAENC
         u8BQ==
X-Gm-Message-State: AJIora9m0eARoK3G2PRhOT2CwOF2axb+QA6UFbv8HhtzOSVE7SwJZxHt
        68FNrIQ1eO3j6091GeRPLk4=
X-Google-Smtp-Source: AGRyM1tez5E2FyjPLs5PGhg40qU0H0E3SQlD0MFHWrBuezbgs9Ad5uO//+4+CT6fA8NmPaeVeHiALg==
X-Received: by 2002:a17:90a:6809:b0:1ec:c213:56c8 with SMTP id p9-20020a17090a680900b001ecc21356c8mr20399771pjj.82.1656330101753;
        Mon, 27 Jun 2022 04:41:41 -0700 (PDT)
Received: from desktop-hypoxic.kamiya.io ([42.120.103.58])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902f34200b0016a2a8c7e8fsm6974942ple.143.2022.06.27.04.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 04:41:41 -0700 (PDT)
From:   Yangxi Xiang <xyangxi5@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        nick black <dankamongmen@gmail.com>
Subject: Re: [PATCH] vt: fix memory overlapping when deleting chars in the buffer
Date:   Mon, 27 Jun 2022 19:40:16 +0800
Message-Id: <20220627114016.11114-1-xyangxi5@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <YrmPi/D4dZAySgll@kroah.com>
References: <YrmPi/D4dZAySgll@kroah.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> And what commit id does this fix, or has it always been broken?

It fixes the commit 81732c3 (tty vt: Fix line garbage in virtual
console on command line edition). The line buffer is not always
broken, because the memcpy utilized the hardware acceleration, whose
result is not deterministic. I fix this issue by replacing the
scr_memcpyw with scr_memmovew used in insert_char, and preserving the
memcpy optimization when the buffers are not overlapping.

Yangxi Xiang
