Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC2475432A5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241292AbiFHOeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241005AbiFHOd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:33:59 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE3B3232BE5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 07:33:57 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id E55B920012BA;
        Wed,  8 Jun 2022 23:33:56 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 258EXt5m185331
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 8 Jun 2022 23:33:56 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 258EXtWc170522
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 8 Jun 2022 23:33:55 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 258EXsHM170521;
        Wed, 8 Jun 2022 23:33:54 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Colin Walters <walters@verbum.org>,
        Peter Jones <pjones@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        Chung-Chiang Cheng <cccheng@synology.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Alexander Larsson <alexl@redhat.com>
Subject: Re: [PATCH v4 3/4] fat: add renameat2 RENAME_EXCHANGE flag support
References: <20220601173204.1372569-1-javierm@redhat.com>
        <20220601173204.1372569-4-javierm@redhat.com>
Date:   Wed, 08 Jun 2022 23:33:54 +0900
In-Reply-To: <20220601173204.1372569-4-javierm@redhat.com> (Javier Martinez
        Canillas's message of "Wed, 1 Jun 2022 19:32:03 +0200")
Message-ID: <87h74vteb1.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/29.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

> +	/* update ".." directory entry info */
> +	if (old_dotdot_de) {
> +		err = vfat_update_dotdot_de(new_dir, old_inode, old_dotdot_bh,
> +					    old_dotdot_de);
> +		if (err)
> +			goto error_old_dotdot;
> +		drop_nlink(old_dir);
> +		inc_nlink(new_dir);
> +	}
> +
> +	if (new_dotdot_de) {
> +		err = vfat_update_dotdot_de(old_dir, new_inode, new_dotdot_bh,
> +					    new_dotdot_de);
> +		if (err)
> +			goto error_new_dotdot;
> +		drop_nlink(new_dir);
> +		inc_nlink(old_dir);
> +	}

Probably, we should change the nlink only if both of dotdot update are
succeed and different file type. Otherwise, we would have to revert the
nlink change on error path (and can remove unnecessary update as bonus).

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
