Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB96D5335A7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 05:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242346AbiEYDRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 23:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240132AbiEYDRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 23:17:12 -0400
Received: from winds.org (winds.org [68.75.195.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45C6734666;
        Tue, 24 May 2022 20:17:08 -0700 (PDT)
Received: by winds.org (Postfix, from userid 100)
        id F00CB1DE8872; Tue, 24 May 2022 23:17:07 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by winds.org (Postfix) with ESMTP id ED9F01DE864A;
        Tue, 24 May 2022 23:17:07 -0400 (EDT)
Date:   Tue, 24 May 2022 23:17:07 -0400 (EDT)
From:   Byron Stanoszek <gandalf@winds.org>
To:     Paulo Alcantara <pc@cjr.nz>
cc:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: CIFS regression mounting vers=1.0 NTLMSSP when hostname is too
 long
In-Reply-To: <874k1nj3p4.fsf@cjr.nz>
Message-ID: <fea279e9-bec2-591c-203e-25385d958d4@winds.org>
References: <e6837098-15d9-acb6-7e34-1923cf8c6fe1@winds.org> <874k1nj3p4.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2022, Paulo Alcantara wrote:

> Could you please try below patch?
>
> Let me know if I missed something else.  Thanks.
>
>> From bf63fb30ac90c06f45e40acbd3bbd2284d8ffffb Mon Sep 17 00:00:00 2001
> From: Paulo Alcantara <pc@cjr.nz>
> Date: Tue, 17 May 2022 17:23:23 -0300
> Subject: [PATCH] cifs: fix ntlmssp on old servers
>
> Some older servers seem to require the workstation name during ntlmssp
> to be at most 15 chars (RFC1001 name length), so truncate it before
> sending when using insecure dialects.
>
> Link: https://lore.kernel.org/r/e6837098-15d9-acb6-7e34-1923cf8c6fe1@winds.org
> Reported-by: Byron Stanoszek <gandalf@winds.org>
> Fixes: 49bd49f983b5 ("cifs: send workstation name during ntlmssp session setup")
> Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
> ---
> fs/cifs/cifsglob.h   | 15 ++++++++++++++-
> fs/cifs/connect.c    | 22 ++++------------------
> fs/cifs/fs_context.c | 29 ++++-------------------------
> fs/cifs/fs_context.h |  2 +-
> fs/cifs/misc.c       |  1 -
> fs/cifs/sess.c       |  6 +++---
> 6 files changed, 26 insertions(+), 49 deletions(-)

Hi Paulo,

I confirm that the patch worked for me (against Linux 5.16.13).

Regards,
  -Byron

