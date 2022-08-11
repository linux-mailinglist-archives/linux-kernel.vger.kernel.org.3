Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF30B58F598
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 03:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiHKBh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 21:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiHKBh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 21:37:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AD2844FA
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 18:37:26 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o3-20020a17090a0a0300b001f7649cd317so3968710pjo.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 18:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=2lUu4re5mh92PVCAHeMiGReQ8Gf65ybDWLIz6zEHu68=;
        b=YTymhStumW2oJOTPTqeh7ld2KIOzF5CoADDzN6DgWkfJJ7gESdFtxgL2CW108b2dze
         Vo2CzPiMOodj56xPKrQ+vJRpuQT+SU/SNusmjWxDN27RM6xk379jy/1WcAIT/Hn0rutv
         oCUKQMy9LJBvLcIdmY97cfEZNYiJgU5OuXp//5qR/cP1d6FzGMIhRJLlHTHo59e8gVFz
         U44Aeau/D3ZA3Vgp0uIJVh+Eb9y3fEo0/JQgidUXLYJcZTC6F7QV/eQp3BCGYHuk4o52
         VUbGi8qfLi8VtUORpjtBO2CEC3CpLuT+NfBowPkoy/lz9D+lyNXIhoBZ/cuU7beBkm9q
         aUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=2lUu4re5mh92PVCAHeMiGReQ8Gf65ybDWLIz6zEHu68=;
        b=kZykvvkul74cQif5+vF9KY4ykrHlttTL6PXslrK65LQhN+k6OxfSyMRdSTWy8xWRYT
         3K+ZT0/A4GH+HNAPL6CK2rpJy13TWkzoebUDZoKTC58db9gdnKFSvjWXE2CnktDRoOAk
         8stoeeTYWDX4DEuFQrhqQcBrSZ7zZ3EXXZ02ffnMKqhAS5rqWHtnBK/YRwa7JDdl/JNv
         b0oXsOn6Jabqz4TiqNQ++zBkXO/sKlWu5Si2bZIPK+/sG/c4i5m7VIrgt9pfv/OhxNPO
         7BPiPEzw01TpRBXCVQ2HN5EWYYI9qQVOjYX+FgZB2AIbelT732jf8iJjrZFlsKShCpQk
         XxzA==
X-Gm-Message-State: ACgBeo0mBCE5i4Lu2vpVsdGnxQ3eJ1nYFBcbsyP+uh2WsVqz2ZgP/oqm
        ABpR8al2z66H5FoFuuaCdcdoyJfJ1vY=
X-Google-Smtp-Source: AA6agR48Mw7pFueIJyO0vMmx/aHyMMwmiJWbljEBNpxxhjR0TYyapwzMPiIAMUgL6Bam0q+CZCcdxw==
X-Received: by 2002:a17:902:d482:b0:16e:e328:fd48 with SMTP id c2-20020a170902d48200b0016ee328fd48mr30038858plg.162.1660181845969;
        Wed, 10 Aug 2022 18:37:25 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:a3c8:d6b9:a5c2:1eca])
        by smtp.gmail.com with ESMTPSA id k3-20020a170902c40300b0016d72804664sm13562920plk.205.2022.08.10.18.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 18:37:25 -0700 (PDT)
Date:   Wed, 10 Aug 2022 18:37:22 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH v5 21/32] Input/joystick/analog: Convert from seq_buf ->
 printbuf
Message-ID: <YvRdUuj1ndWoTFUc@google.com>
References: <20220808024128.3219082-1-willy@infradead.org>
 <20220808024128.3219082-22-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808024128.3219082-22-willy@infradead.org>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 03:41:17AM +0100, Matthew Wilcox (Oracle) wrote:
> From: Kent Overstreet <kent.overstreet@gmail.com>
> 
> seq_buf is being deprecated, this converts to printbuf.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
