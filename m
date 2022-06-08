Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D64F543A2D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 19:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiFHRXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 13:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiFHRV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:21:58 -0400
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB001480110
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 10:10:28 -0700 (PDT)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id B50262051589;
        Thu,  9 Jun 2022 02:10:27 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 258HAQOX189516
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 9 Jun 2022 02:10:27 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.16.1/8.16.1/Debian-3) with ESMTPS id 258HAQh2178851
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 9 Jun 2022 02:10:26 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.16.1/8.16.1/Submit) id 258HAPYe178847;
        Thu, 9 Jun 2022 02:10:25 +0900
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
        <87h74vteb1.fsf@mail.parknet.co.jp>
        <ddd3eb76-5595-4946-95c2-067d5fbaae99@redhat.com>
Date:   Thu, 09 Jun 2022 02:10:25 +0900
In-Reply-To: <ddd3eb76-5595-4946-95c2-067d5fbaae99@redhat.com> (Javier
        Martinez Canillas's message of "Wed, 8 Jun 2022 18:55:46 +0200")
Message-ID: <87czfjt726.fsf@mail.parknet.co.jp>
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

> On 6/8/22 16:33, OGAWA Hirofumi wrote:
>> Javier Martinez Canillas <javierm@redhat.com> writes:
>> 
>>> +	/* update ".." directory entry info */
>>> +	if (old_dotdot_de) {
>>> +		err = vfat_update_dotdot_de(new_dir, old_inode, old_dotdot_bh,
>>> +					    old_dotdot_de);
>>> +		if (err)
>>> +			goto error_old_dotdot;
>>> +		drop_nlink(old_dir);
>>> +		inc_nlink(new_dir);
>>> +	}
>>> +
>>> +	if (new_dotdot_de) {
>>> +		err = vfat_update_dotdot_de(old_dir, new_inode, new_dotdot_bh,
>>> +					    new_dotdot_de);
>>> +		if (err)
>>> +			goto error_new_dotdot;
>>> +		drop_nlink(new_dir);
>>> +		inc_nlink(old_dir);
>>> +	}
>> 
>> Probably, we should change the nlink only if both of dotdot update are
>> succeed and different file type. Otherwise, we would have to revert the
>> nlink change on error path (and can remove unnecessary update as bonus).
>> 
>
> Agreed. I'll wait a few days before posting v5 in case you have more
> comments on the other patches.

Ok. I have no comment other than this at least for now (reviewed all
patches). If I found more on re-review I will send email.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
