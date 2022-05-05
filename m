Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F56251C9DE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385569AbiEEUH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244961AbiEEUHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:07:51 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6F45F26D
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 13:04:11 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id fv2so5143986pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 13:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DuOd93x9EUJ7S65xNDpdbXcFskeeX72uxuXiIO78KtA=;
        b=Ll+Ekj0iS+Iofhzt5HWVh6Rp0V4QpfFfACbaKa2m/94QOv30zPNIJHelyzhm8ihi0p
         /Gfeov/geUeDrhE6VDPbcE+TkGRE7f8mQ5WZCZLgTzYIBTGI20OFvX+7NENFBAP2vMw+
         bA+N7n31QCK3WwV11ZKpgtd9ce7UI5RTrHphCmdPZE29GMeZUJ/S4Yb0xiWqR9CNVtRa
         VAnyZGDgnGRVoqcU9d4Q9wX9XOYarS0GwJaRFqkRdhPLdTaRn2ZGHCoEyUTXI/rFJp1L
         M0JNXXNSXt6x1ByOj/6YPGcJIO6ed7JkuFsiu0YjZ7syvjz2lYstMtujpLAGJ+0Mzb1t
         ltlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DuOd93x9EUJ7S65xNDpdbXcFskeeX72uxuXiIO78KtA=;
        b=1FBlz27x34Qa5xSn0t8WQrOK5yS4Vs+JakMPIAB2tgVnJoTtTJ9aqeCMZWInaRF4XB
         7Br4vtQ55dHyVSP7Y7LpPMap7JErM252j//ziPkdhhLgoXFCrNOZKBwgHWBy7rFJfmdn
         o/7e2XONXV+1wAw5pq1O6bt6mYY91/vikyInFbCJnx8Mo89V3XvSdltYweoek8NZOYpX
         9cmzZJoSW6OnIJ1gyTh3DGCS0+p88Z2APMt60NLqNIZDvo5JHv6upol1jDUkjYOPmvaE
         nI3wzFEWX9Y7EOkkQhOfvwkhpWdLOdeT3Hip/t5mnfp5XzOdu3Ek00MSG8cULsI+3lrO
         qM0Q==
X-Gm-Message-State: AOAM532Lom1z7t6uWOmdSfTZheELtbwmIgKI6z7dOeXUwsPKilG51IiP
        /TcBWhA6W0b7DxVf/zNUtq8=
X-Google-Smtp-Source: ABdhPJxwfwJ6BOhPYZNldrJSwx1NI60Ig04rh9CKA4IDjIxmCgQ3qlks2uJs4rm26sPrSynbd2/BFQ==
X-Received: by 2002:a17:90a:4581:b0:1bc:d215:8722 with SMTP id v1-20020a17090a458100b001bcd2158722mr8042943pjg.149.1651781051368;
        Thu, 05 May 2022 13:04:11 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:29a5])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902c20100b0015ec44d25dasm9164pll.235.2022.05.05.13.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 13:04:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 5 May 2022 10:04:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] kernfs: Introduce interface to access global
 kernfs_open_file_mutex.
Message-ID: <YnQtuf0Gsjl8Qj+D@slm.duckdns.org>
References: <20220428055431.3826852-1-imran.f.khan@oracle.com>
 <20220428055431.3826852-5-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428055431.3826852-5-imran.f.khan@oracle.com>
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

On Thu, Apr 28, 2022 at 03:54:30PM +1000, Imran Khan wrote:
> This allows to change underlying mutex locking, without needing to change
> the users of the lock. For example next patch modifies this interface to
> use hashed mutexes in place of a single global kernfs_open_file_mutex.
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
