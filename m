Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BEB4C11A6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbiBWLmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240129AbiBWLls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:41:48 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC5398594
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:41:16 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m22so2422317pja.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2FdpJtwwptOqf9HZS4rYWvt/1fNJrXfcPdRcbqchc9A=;
        b=X2fNNniPtOIIm9CDvNXZh5lyGbvsRJGvOF/n0CLswxgJ/CzMPKNkAPld4djZqv/ioX
         Uzm2CAMBk3pA19cmDysAKvaErW3p3oUVFRUZ59uV4PtR0oA5xQ13eSfjlwqnn3vAkWHo
         Unv1kFIJoKvI7fs4kUZJnwWzg/XnwLpJCp3Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2FdpJtwwptOqf9HZS4rYWvt/1fNJrXfcPdRcbqchc9A=;
        b=z2FFdqiSLcxAaRYOjQl+ouRocX7iiqLkNXslKfKBTbd7f5nqaAlt0L0BB+eVnaT/pe
         8bJROoWKHxgapZrlNvixiBTdUfEpvr01DmfJeziMoIgiDwdxZCiG3HFAE/eBcWJHbAg1
         5BqJVabfXNbMTpusiHXmn4bkkrUk2D1UgUF3yG8Qz5jb3Oh6qx85flp68F46ZeM+V+fT
         0O50b7VZYmL9EpRLp8Tf/yFMDbkfgBK/V+dpP0EwJ8ktXSZA/Q06hdH/tJ7V05qMcbqa
         CebvX2ek2U1qq8srt86lkVddrysEhoTuk9xRdtTgu5APCdoyAYTkEZCMBBxCLCLWoYYN
         u5Kg==
X-Gm-Message-State: AOAM532lkkzWM0lFOxaieqehwwhEqrVOp9JlL/Vv+io7eYzThIKeylph
        /BuNHPMat5549DkGNe6J6r7QDg==
X-Google-Smtp-Source: ABdhPJzAvBfKYhgVJwO+GzBK5Q6lxoYGCvV1OIKMlKQnwiWxMUYcDVdQosyf4QhvhTpuw4ls4Xhd1g==
X-Received: by 2002:a17:902:e94e:b0:14d:85a1:c846 with SMTP id b14-20020a170902e94e00b0014d85a1c846mr27585145pll.120.1645616476128;
        Wed, 23 Feb 2022 03:41:16 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:d2bd:9913:3c85:9aca])
        by smtp.gmail.com with ESMTPSA id o3sm17936752pfu.50.2022.02.23.03.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 03:41:15 -0800 (PST)
Date:   Wed, 23 Feb 2022 11:41:09 +0000
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-kernel@vger.kernel.org, bhe@redhat.com,
        akpm@linux-foundation.org, anton@enomsg.org, ccross@android.com,
        dyoung@redhat.com, feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        senozhatsky@chromium.org, tony.luck@intel.com, vgoyal@redhat.com
Subject: Re: [PATCH V6] panic: Move panic_print before kmsg dumpers
Message-ID: <YhYdVYYapkaVdvZE@google.com>
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YgvRe92hEvj5mEUS@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgvRe92hEvj5mEUS@alley>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/02/15 17:14), Petr Mladek wrote:
> Makes sense and looks good to me.
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

FWIW

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
