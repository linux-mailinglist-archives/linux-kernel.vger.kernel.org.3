Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C7058BE4E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 01:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiHGXaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 19:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiHGXaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 19:30:21 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C4BE99
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 16:30:16 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r22so4769144pgm.5
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 16:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=qbL2Ymxz5e7KekDdLOCsw8SbD8/sAmLdT/zwTpI/iMs=;
        b=R5iWcoAJGfltcXw8d6iMH8EJQIedF26xa3nF2pmcTBWV6ZAtwiGpdJkc3ESIMqS+r6
         tYPg8LqY9DG4M3pRYvgfAvNGX5cvpMSLvMlnyoTTbAd1toInkrjCfGwuWSvDbmgmRjSE
         fL4+HzBnyQUMI44qpxiPIx/42OSGfnvkxEyG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=qbL2Ymxz5e7KekDdLOCsw8SbD8/sAmLdT/zwTpI/iMs=;
        b=6dvJN5jogG9vfwGwYuhRNUirPtCLUMcwoCOm1ZmvVa1bdmM8J2cbauLL0v/1amc59B
         v1NhiPzElWDvsbuKMbnoOt1nVoRKaK409T5YMb4ANqShLsnznzGsrxneS0BgDv0n5XSz
         zyF1G5eMOv6UVBmOPFL0f23SPq2OYM70LLsoptf2XvJh1faAI73+r6FOW3XabzXj/B9M
         aA198yLPA5gVAKQoj0zA0X4YywDg7yJ46x0ELWWxaTtYUrcBp+tneXTWxPSpOU9LcssM
         qsCLBFaPDd7Gvv4y4RWbfOUoYyO+Rdqmdy8c4vQ4uw5lwhsmyXmQbDvvwPzAv6o8XDag
         lc6w==
X-Gm-Message-State: ACgBeo2C+bR/uSN0kJ/IrzIbTJx6pmA2ig48IcTbdm2mwuMAcPazrZ0m
        53yDmiXB1ogW7HA/Lw76dNQ+OQ==
X-Google-Smtp-Source: AA6agR6sadHb5Wxix/DeyrpnxhLihE5ZhtxH5f6V2cbNJj5GTJgIb+1mvG9rSxRjJPfew0QXv55+NQ==
X-Received: by 2002:a65:6949:0:b0:41c:cb9d:3d1f with SMTP id w9-20020a656949000000b0041ccb9d3d1fmr13462189pgq.334.1659915016477;
        Sun, 07 Aug 2022 16:30:16 -0700 (PDT)
Received: from google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id d6-20020a170903230600b0016efc27ca98sm7127955plh.169.2022.08.07.16.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 16:30:15 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
X-Google-Original-From: Daniil Lunev <dlunev@google.com>
Date:   Mon, 8 Aug 2022 09:30:07 +1000
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>
Cc:     James@vger.kernel.org, E.J.Bottomley@vger.kernel.org,
        jejb@linux.vnet.ibm.com, Martin@vger.kernel.org,
        K.Petersen@vger.kernel.org, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bean@vger.kernel.org, Huo@vger.kernel.org, beanhuo@micron.com
Subject: Re: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
Message-ID: <YvBK/8yeohLhu2Za@google.com>
References: <1655727966-31584-1-git-send-email-Arthur.Simchaev@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655727966-31584-1-git-send-email-Arthur.Simchaev@wdc.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 03:26:06PM +0300, Arthur Simchaev wrote:
> The bsg driver allows user space to send device management commands.
> As such, it is often used by field application engineers to debug various problems,
> and as a test bed for new features as well.
> 
> Let's not bound ourself to hard coded descriptor sizes, as the new
> Descriptors that supports new features are not defined yet.
Can you clarify what you mean "hard-coded"? The descriptor size is initialized
as QUERY_DESC_MAX_SIZE, and updated in `ufshcd_update_desc_length`, which is
called with the actual size upon finishing `ufshcd_read_desc_param`.

The function you are removing - `ufs_bsg_get_query_desc_size` - doesn't seem to
reject requests on incompatible size, only to restrict the size of the query.
The way the code is written - if I read it right - will lead to truncation of
the response if the size of the requested response is less than the actual
descriptor size, but otherwise you should get full descriptor back.

Can you provide a specific example where you see the problem to arise?

Thanks,
Daniil
