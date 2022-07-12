Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6894557261D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 21:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiGLTmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 15:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbiGLTlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 15:41:46 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55665EABD1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 12:19:41 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 1A545C01C; Tue, 12 Jul 2022 21:19:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1657653580; bh=4kLG5LfYXoQgdqNM7ebFbY8AeXr+/H9XyIri+iAlNQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v0oFbMjIxERf2CyIUqb0YqlcSCRV8PzxbO8OsUI2Iyux9aWIxZUpzAoN4zEMELZLD
         N7LONo04WSxahFCs2xi6Y65w6EJRR5LoBAEhnFKAb6RqEuVCmS3rzlAh6dyZUclV5r
         SHc9m1lLrlZJ6wTvqn5J0wz54osHZKKpW3oU2epIPYsSzwZ4e0uTW38uOCdSsAvu6j
         TcjCMjQCT7+UOB0Z5e26V8H7Dd05NeHqKFRQKEkS1Tsk4xGxFf1vtJs4Dr+xllo8Xs
         xGwifzBYsiOtVRvGHWzCiyz0fYXs+drPq/CM29nDQHQOUFbYt+s0dtsKQH0REz/RPn
         5RHH7Dkw5LbKg==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 4BD4BC009;
        Tue, 12 Jul 2022 21:19:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1657653579; bh=4kLG5LfYXoQgdqNM7ebFbY8AeXr+/H9XyIri+iAlNQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0IiI1fsRFjKICPSblsZCIHomSwfHPMphPZP2yPKsl+CpSru/Euv3vgMMMqE29FRDT
         RwijwKYapRiIBz2nWUIrcm6Wqio1hONVlRKXSllIyWgvu069KY38hZz9nbsiODehp9
         NMUUO1OA0GUHqyVjdc70oB5udFc0V5V8l/ZgGAw0Fh7QQVXlTuG3ISWoOuhcnHOUss
         MMdho11wGoaoR+boWt+TBo+gZ8cz/fFsIdanzO+87V/YfaUj8gUysxrkk98zpuHWFK
         jPzStjqluYA8J/8wMsDOC07aIXRyYoSOlq/ufpFn3EqJfZa+DxCrSLpsCcFc4hdIOg
         /mDpp+xpE5HeQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id a0c93479;
        Tue, 12 Jul 2022 19:19:33 +0000 (UTC)
Date:   Wed, 13 Jul 2022 04:19:18 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs-developer@lists.sourceforge.net
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        linux-kernel@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>
Subject: Re: [PATCH] 9p: roll p9_tag_remove into p9_req_put
Message-ID: <Ys3JNvQRzrhG/56T@codewreck.org>
References: <20220712060801.2487140-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220712060801.2487140-1-asmadeus@codewreck.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dominique Martinet wrote on Tue, Jul 12, 2022 at 03:08:01PM +0900:
> diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
> index 007c3f45fe05..507974ce880c 100644
> --- a/net/9p/trans_fd.c
> +++ b/net/9p/trans_fd.c
> @@ -272,6 +272,8 @@ static int p9_fd_read(struct p9_client *client, void *v, int len)
>   *
>   */
>  
> +static int failme;
> +

woops, removed that bit.
At least I didn't commit the code that actually triggered the fail...

>  static void p9_read_work(struct work_struct *work)
>  {
>  	__poll_t n;

--
Dominique
