Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED7B58E7AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 09:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiHJHPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 03:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiHJHPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 03:15:03 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA8B81B3B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 00:14:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id p125so9383230pfp.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=OSs5k2JzZ1v3qOKBenh3reA8UtTc/55dy3uwB9bpFyc=;
        b=fRII53OuDbSrBGUENSJcamKT3/9cjXKT+mjl/O9p0ErgCPvk3ARW83xCI8W563pOr1
         +Ux3sOkTb8y2WeTYBti4JzyFqBU11q7Rn/O0ynkK1/tdLUErsz1SfDn+4CMvCYV17Pf6
         R4B62Af62kodXT2tieQEfowlHgByd2TqZYCtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=OSs5k2JzZ1v3qOKBenh3reA8UtTc/55dy3uwB9bpFyc=;
        b=bAZMOtLdik5dTEcnpMRcjGDuqriXlIPTxgLbGSbvdhD1J5apNZstnFnO2k7VMysimS
         xusSoDKhU0OdwVyOhN0zpRZlhfz0ChT5DTUf/+UEtircsFVvB1oYwRxnP1MOvKCkOUSj
         XtDFPGnb6PPbXsNqHJWeYvSwxo9HtpWA9PUdqA9zhAMpOAvURgTD7i40G/pYSHICXzXF
         ZKz9RqUxuX2/xunY0cyDiPXjz4jpBpySzdciugEGP3rYzH0rvNTFwnRS2ia/OeK/Jys4
         QqCDczq7KP3jtjOpAfG6X/DQR3HVhrDoxExcdSIk4nXtumZO0crV5aGcSgRuJswnJLNx
         FFBg==
X-Gm-Message-State: ACgBeo38MU3+Z8tLEO5Vq6ic6W6B91KLNTtllQ69FJFKv4FEwysXIu3t
        QMw+odDEI+9OPw+TjDdVFeYwag==
X-Google-Smtp-Source: AA6agR6SwVqLDNEUbqPEMGyYnHiPZHPaAyuG6LplTRCyy+nadhW71qzoHeLQm0fBHMameJfHF5CDrg==
X-Received: by 2002:a05:6a00:2387:b0:52f:17a0:628c with SMTP id f7-20020a056a00238700b0052f17a0628cmr15596370pfc.17.1660115694664;
        Wed, 10 Aug 2022 00:14:54 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:69dc:40cc:db3b:f90e])
        by smtp.gmail.com with ESMTPSA id m6-20020a1709026bc600b0016ee4b0bd60sm11943434plt.166.2022.08.10.00.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 00:14:54 -0700 (PDT)
Date:   Wed, 10 Aug 2022 16:14:48 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        jack@suse.com, adilger.kernel@dilger.ca, tytso@mit.edu,
        stable@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexey Romanov <avromanov@sberdevices.ru>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Lukas Czerner <lczerner@redhat.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] Revert "zram: remove double compression logic"
Message-ID: <YvNa6J/neNxXNSTV@google.com>
References: <YvJKwCXewHmuWGdh@google.com>
 <20220810070609.14402-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810070609.14402-1-jslaby@suse.cz>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/08/10 09:06), Jiri Slaby wrote:
> This reverts commit e7be8d1dd983156bbdd22c0319b71119a8fbb697 as it
> causes zram failures. It does not revert cleanly, PTR_ERR handling was
> introduced in the meantime. This is handled by appropriate IS_ERR.
> 
> When under memory pressure, zs_malloc() can fail. Before the above
> commit, the allocation was retried with direct reclaim enabled
> (GFP_NOIO). After the commit, it is not -- only __GFP_KSWAPD_RECLAIM is
> tried.
> 
> So when the failure occurs under memory pressure, the overlaying
> filesystem such as ext2 (mounted by ext4 module in this case) can emit
> failures, making the (file)system unusable:
>   EXT4-fs warning (device zram0): ext4_end_bio:343: I/O error 10 writing to inode 16386 starting block 159744)
>   Buffer I/O error on device zram0, logical block 159744
> 
> With direct reclaim, memory is really reclaimed and allocation succeeds,
> eventually. In the worst case, the oom killer is invoked, which is
> proper outcome if user sets up zram too large (in comparison to
> available RAM).
> 
> This very diff doesn't apply to 5.19 (stable) cleanly (see PTR_ERR note
> above). Use revert of e7be8d1dd983 directly.
> 
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1202203
> Fixes: e7be8d1dd983 ("zram: remove double compression logic")
> Cc: stable@vger.kernel.org # 5.19
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Nitin Gupta <ngupta@vflare.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Alexey Romanov <avromanov@sberdevices.ru>
> Cc: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> Cc: Lukas Czerner <lczerner@redhat.com>
> Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
