Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B150D4F677B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbiDFReD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239365AbiDFRdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:33:42 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFA415EDE7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:39:09 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so3301598fac.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 08:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V6NesqS8T+uaIQBk3Ioy4XttyfnAiZ+4Unbo6Ixdr/g=;
        b=K2OYW3cQXtcIASumLAOQH2NCn8bX5/LS561qkTuyt1jKdYAnPDOCn7RjQbhjVyFIRB
         gmAG4NToDt2xH2Rqht5pWCSuXSMa8kprf376kccdXhs245uMcWV9CiUqp5weYPIh8tQl
         8hIp0s6U3LHMWhkOcfdirKuje4iDrlRmGrAcLSS6RXCZ5KamLAp83U4m/CVf+I0DzrUa
         bMcYVXrpmDzx+Jmy/TlQaAqZpfWabN3AtZBJxi1aOmElMLtzYDLGTwLB8/Z91Ynqar7C
         XZLwvy9aG4zywaZU9xJDBRTxQrPOvXAzmXjmCaFyC6zAfHZIEJi9HN49LBBudO8fyYEo
         ZrYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=V6NesqS8T+uaIQBk3Ioy4XttyfnAiZ+4Unbo6Ixdr/g=;
        b=p91SGkz/W56JIefwNwrwImU0nspfL4olPvDfBh7SiAFEQ9fAgkfljl9n/bw2nzJZw+
         lab37XQlXt0fdozaQHgi2CypvDGp/6kmHb7iXCVupnM6N3wLikMzExwBDzBYhY4oG346
         cA1yfX7keTj9BbAWSpfkfHIRL/p3DONzcQopA9QUyQyoO6lDV2u9DJ05DxojpU/HRs9+
         +N/l6OMexNgH1gAcppXjGYbc2xnsDFweQuxDAUAXA7GsPsngWPJMZNJq5YVBpF1OdvsZ
         IkYpHGt2OBlQgaJ5stCJ/5oHqGUOZ+Jtw6HH1ao9HHBIHoM5iiGWnLwuIZh0zmx1QUW5
         iGkQ==
X-Gm-Message-State: AOAM531wn5TKALZhv7PvxH2UgupALtlhmTuih49kpejvBa4VZkZ5xU09
        bhw0z9hYsbGzZLcUXRDtbQ8=
X-Google-Smtp-Source: ABdhPJxlgD7xC0amjI9GG2hFxHgR2AjpDP8ExNMOBTn8yGef4MYQoM5mnOcNcMEzHJvFO7s6KqK9gQ==
X-Received: by 2002:a05:6870:73cb:b0:e1:e897:5463 with SMTP id a11-20020a05687073cb00b000e1e8975463mr4275962oan.255.1649259548806;
        Wed, 06 Apr 2022 08:39:08 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h11-20020a056870170b00b000e1f0e0a943sm4194341oae.2.2022.04.06.08.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:39:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 6 Apr 2022 08:39:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Ben Young Tae Kim <ytkim@qca.qualcomm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Bluetooth: hci_qca: Use del_timer_sync() before freeing
Message-ID: <20220406153907.GA1994259@roeck-us.net>
References: <20220404182236.1caa174e@rorschach.local.home>
 <97d1cc84-890c-3fcf-2efc-645633cd36b2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97d1cc84-890c-3fcf-2efc-645633cd36b2@gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2022 at 05:22:00PM -0700, Eric Dumazet wrote:
> 
> On 4/4/22 15:22, Steven Rostedt wrote:
> > [ Resending due to cut and paste failure of email address ]
> > 
> > From: Steven Rostedt (Google) <rostedt@goodmis.org>
> > 
> > While looking at a crash report on a timer list being corrupted, which
> > usually happens when a timer is freed while still active. This is
> > commonly triggered by code calling del_timer() instead of
> > del_timer_sync() just before freeing.
> > 
> > One possible culprit is the hci_qca driver, which does exactly that.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 0ff252c1976da ("Bluetooth: hciuart: Add support QCA chipset for
> > UART") Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index f6e91fb432a3..73a8c72b5aae 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -696,8 +696,8 @@ static int qca_close(struct hci_uart *hu)
> >   	skb_queue_purge(&qca->tx_wait_q);
> >   	skb_queue_purge(&qca->txq);
> >   	skb_queue_purge(&qca->rx_memdump_q);
> > -	del_timer(&qca->tx_idle_timer);
> > -	del_timer(&qca->wake_retrans_timer);
> > +	del_timer_sync(&qca->tx_idle_timer);
> > +	del_timer_sync(&qca->wake_retrans_timer);
> 
> 
> It seems the wake_retrans_timer could be re-armed from a work queue.
> 
> So perhaps we need to make sure qca->workqueue is destroyed
> 
> before these del_timer_sync() calls ?
> 
> >   	destroy_workqueue(qca->workqueue);
> 
> 
> ie move this destroy_workqueue() up ?
> 

What prevents the timer code from queueing work into the destroyed
workqueue ?

Thanks,
Guenter
