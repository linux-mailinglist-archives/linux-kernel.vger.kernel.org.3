Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C992154A77A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 05:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343843AbiFNDTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 23:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbiFNDTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 23:19:07 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5C42E0B8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 20:19:06 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 15so7451499pfy.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 20:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/e6JAN91T9e89/lPNtlCsxwSmh8l6RVHLbvzMmDBIwc=;
        b=dq0Y6PayEq+t+JXCl6y6hIB+rMABYHAt1q71bZlxgrvfqjx+UuQKYAv0Iv2bbY0XNn
         b1IcC9sJd3ZqaB9xTr7Tk05idcEREChlxaVSaXiJsJF8hcsDPgE3b5Hf9cumro46hB9t
         UU9oBGxMHOhdtStmucng2teG43v2Cx8HVlG4l9+Va+GGVcX8HSXK+iMgUykA0AFo8Hkn
         aw+2g5UeZQyyW4YGD6xW/tiYuVzuKBKAv9WdmVlGAAQfJafk/l4BtK+zr9UxJ99+5Y3S
         FJD1QBdV2sU80bHS4ZCaM4rHYLIuPISoaNaa9Rf+DjxmM+DFbxWi5U/TuzL92pjGk4/w
         b1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/e6JAN91T9e89/lPNtlCsxwSmh8l6RVHLbvzMmDBIwc=;
        b=39YrSWka6FA/USozkJzWpcnErqMi+/tleNDZ9gEeGvdTR0G43T3vBxecfDoHGN3d+6
         ZiXB/LWeI/UknrsT5vC7htafrMMxUCZvpmyUWr7RGvaVNL5lDkPTbJLlYUqsXvDxiarx
         pAjEN7tCDwvKrnvvZnu4QwF2MJQ9Pe0ee6rXhoQ6jJNb0GGn1LeWdbGm4HBETTVGIFR6
         ixHTp/d8/7hG8ot/76I8YoajzcKBxPF2nsduvdCXbbzp84fcbqpuSt/bk6LVY+vaFMgH
         sdPPNR/i7Dw/LvyNuXZYm9WGAtSYNZtnY11R4wenmjBbi7lv7egpnThpuE7qPzA9g+1m
         e2KQ==
X-Gm-Message-State: AOAM531xBtwVpcxcMKskd8p9NM4Pin5ph/6CkKUcyIojxX16iStZj30S
        j9DyKzSoBvwxNpdhOCn+gMNJwHZR61Q=
X-Google-Smtp-Source: ABdhPJzDff4vhZ4C5TjzjV0yIVLw0dB2fQEzBghjbmxfv1Y/aC16pd1b9VpKXpCHoUBq2d7/hUn+vw==
X-Received: by 2002:a63:40c3:0:b0:3fd:12b8:3207 with SMTP id n186-20020a6340c3000000b003fd12b83207mr2579618pga.57.1655176745797;
        Mon, 13 Jun 2022 20:19:05 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:ea37])
        by smtp.gmail.com with ESMTPSA id jb2-20020a170903258200b0015e8d4eb25asm5883262plb.164.2022.06.13.20.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 20:19:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 13 Jun 2022 17:19:03 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/4] kernfs: make ->attr.open RCU protected.
Message-ID: <Yqf+J/P1/24i6rN9@slm.duckdns.org>
References: <20220614020840.546013-1-imran.f.khan@oracle.com>
 <20220614020840.546013-2-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614020840.546013-2-imran.f.khan@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 12:08:37PM +1000, Imran Khan wrote:
> +static struct kernfs_open_node *
> +kernfs_deref_open_node(struct kernfs_open_file *of, struct kernfs_node *kn)
> +{
> +	struct kernfs_open_node *on;
> +	bool deref_ok;
> +
> +	deref_ok = (of ? !list_empty(&of->list) : false) ||
> +		   lockdep_is_held(&kernfs_open_file_mutex);
> +
> +	on = rcu_dereference_check(kn->attr.open, deref_ok);
> +
> +	return on;
> +}

Hahahaha didn't know they'd be taking two different arguments. Sorry about
the many iterations but it'd probably be better to have two different
versions for the two argument types. Other than that, looks fine to me.

Thanks.

-- 
tejun
