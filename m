Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61BB550640
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 19:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiFRRHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 13:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiFRRHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 13:07:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541CB558E;
        Sat, 18 Jun 2022 10:07:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E41DF60F08;
        Sat, 18 Jun 2022 17:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51D13C3411D;
        Sat, 18 Jun 2022 17:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655572062;
        bh=KqmNordb+QHA2ZI4oQIWOsfJ2gjxU8YjcD2HdXlvMzs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ELooSgG/KSJ7yFrax/Y2UJqiGNJlBJKaVV3AuacAx8foXpCJ/x7LCblKOywfWoUDy
         t1Z7NFEOPotYx1Hhg9GHWUolRA2LiruJX6MjwGIbbu82G1uaw+pdulwYSDtxR1A8fs
         KuqAiSJsHBPijwOK7EEH1jtX+1NXbPNcY0md992sI5ZzDvHTkGziZ4EDjSDitVd/Qr
         DQ6WIywLeZ2m/TmIcwWzj3sAxUKXOQKf3OWVcvLGbO+1kzTTH65miHIQGIdFmlNPkg
         xqCeLTqnELDuiZN3jglByq9zDhbV2HyUC2SCXvV7M9+NW9lZ35iCoyljjVIeFfrEDP
         43tMXCXxdowWA==
Received: by mail-pl1-f175.google.com with SMTP id k7so6319597plg.7;
        Sat, 18 Jun 2022 10:07:42 -0700 (PDT)
X-Gm-Message-State: AJIora+oc25Lu/Oe6NKsPppx8NRDAaLVZcAZ5S7KNueZAlF2p1sRX+7K
        aaU/CPchQvN447dum33fn+iB27p04HBxC425Eh4=
X-Google-Smtp-Source: AGRyM1sNRZu0x7H3Y0OO0426x3Ze9/v/FHGS+rQpIQqiGzcKpJfW9zzE6W7AVtBlMKAfJLfQm+5wy2fo5G+EVxxh0I8=
X-Received: by 2002:a17:903:1c5:b0:167:71bd:462f with SMTP id
 e5-20020a17090301c500b0016771bd462fmr15669728plh.65.1655572061950; Sat, 18
 Jun 2022 10:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220618060850.4058525-1-windhl@126.com>
In-Reply-To: <20220618060850.4058525-1-windhl@126.com>
From:   Timur Tabi <timur@kernel.org>
Date:   Sat, 18 Jun 2022 12:07:05 -0500
X-Gmail-Original-Message-ID: <CAOZdJXU6R1wma8VXwfPYzq6eSkT84DiXb+3eQCEVanLZC2LQ3w@mail.gmail.com>
Message-ID: <CAOZdJXU6R1wma8VXwfPYzq6eSkT84DiXb+3eQCEVanLZC2LQ3w@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: Fix refcount leak bug in ucc_uart.c
To:     Liang He <windhl@126.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jirislaby@kernel.org,
        PowerPC Mailing List <linuxppc-dev@lists.ozlabs.org>,
        linux-serial@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2022 at 1:09 AM Liang He <windhl@126.com> wrote:
>
> In soc_info(), of_find_node_by_type() will return a node pointer
> with refcount incremented. We should use of_node_put() when it is
> not used anymore.
>
> Signed-off-by: Liang He <windhl@126.com>

Acked-by: Timur Tabi <timur@kernel.org>
