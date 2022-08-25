Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F645A0AD8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbiHYH6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiHYH6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:58:36 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1779BB53
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:58:35 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so4093898pjj.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=HVtd613i0UXrrnb6Zp85lYyQXZ6YePl/EqH6qWZBvRI=;
        b=F1h+n/l+1PwWbShr5qGzbgiajlXDQrNiZbm6BzE65WHoz6qAo1nD1YeBb4aqO+SyuE
         Y9s7xQfE7q/KE0MdrhAU8Qd7Y/nmo6DWRcnW3N5RM5+D0OYFfIXJzf/jr2kDcJiCbcEG
         jWhrg6EhZDZ+rrQsdhFbEh+AFk6BrywCkc7SM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=HVtd613i0UXrrnb6Zp85lYyQXZ6YePl/EqH6qWZBvRI=;
        b=D6LZbzlUxqH6RnPzQ8ISokLR96/Sdf8eVFIIHhkLoDMM6f6meoITBkpIoq5MdES7rI
         T7+qfGVa+Ssh1guG4DuFWSu3l8LHCJrY/6cXctADViZkU1EMJGhhYNC2mUt06Mdog4u/
         MpylYm5sqrWwSnUnqewGmUbusgam94cBSp0TtWrm9QCd/MTvP8v2qXgQHN6V4fJwIhqW
         tsAYXg4pcLhOED/7MCh9YedBjFvIrS0hpb1PPlCW4F0rWD8XrDYL6Tllwrqa7mnfvNs7
         XoxeuqobmmdkbceEyDX/y+ndZEO/rVfxo+X4CiSjo3dqlt1DZ59YHOPH/kkKQ7Y4I8Yc
         3eeg==
X-Gm-Message-State: ACgBeo00c+q8apSx4PbtxztQem7O66m7YTswoXCJ4vCLCZ0PwpgGyPlA
        vuhAPmxizYuivgdLlzXgGUjJ0kLaJfZ2PQ==
X-Google-Smtp-Source: AA6agR4W4NP/I95GVaCuzaT5x8cXnhROop5eM3MXOl2QIifvixPndTRA5KpdpsgVMmrmsUIaDqiL7w==
X-Received: by 2002:a17:902:b20a:b0:172:7385:ea63 with SMTP id t10-20020a170902b20a00b001727385ea63mr2812693plr.54.1661414314893;
        Thu, 25 Aug 2022 00:58:34 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:af71:ab2c:8adb:fb1b])
        by smtp.gmail.com with ESMTPSA id bn4-20020a17090b0a8400b001fa9e7b0c3esm2763837pjb.41.2022.08.25.00.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 00:58:34 -0700 (PDT)
Date:   Thu, 25 Aug 2022 16:58:29 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Romanov <avromanov@sberdevices.ru>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, ngupta@vflare.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
Subject: Re: [PATCH v2] zram: don't retry compress incompressible page
Message-ID: <YwcrpdA0ppFR2i8S@google.com>
References: <20220824113117.78849-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824113117.78849-1-avromanov@sberdevices.ru>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/08/24 14:31), Alexey Romanov wrote:
> It doesn't make sense for us to retry to compress an uncompressible
> page (comp_len == PAGE_SIZE) in zsmalloc slowpath, because we will
> be storing it uncompressed anyway. We can avoid wasting time on
> another compression attempt. It is enough to take lock
> (zcomp_stream_get) and execute the code below.
> 
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
