Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA1A531DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiEWVdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiEWVdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:33:00 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9093213CC1
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 14:32:53 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220523213247euoutp020d0dd4f5daf529732f3be2c6c2d18353~x2WVh5cbk3148331483euoutp02Z
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 21:32:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220523213247euoutp020d0dd4f5daf529732f3be2c6c2d18353~x2WVh5cbk3148331483euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653341567;
        bh=CuA90U34Sy398IZHnKSyqiV58r/MsKlMAgzP1H/ssfQ=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=QN9eyH9ylCEMp7ECmyoXYI5174UrezW5k0Fqlc0XQdccTzB5bQ5e7UD87WjQzBb6X
         oRf5WqPLsYtQWynyYgBmEKOveosnPt4V3KYPH3QfpN33kN8k18RIFBoFmBwiFbrY/W
         /L+iGkGdTJEj+ec0HQSc+ldpQT4VXQxJlsUHDOv4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220523213247eucas1p1d18fd34f643aba4ced6c0504b1db29c2~x2WVHLigO2492924929eucas1p1R;
        Mon, 23 May 2022 21:32:47 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id F9.48.10260.F7DFB826; Mon, 23
        May 2022 22:32:47 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220523213246eucas1p2d0da08d931a996cd3410eda1c2fd48c0~x2WUiJNDA1924419244eucas1p2Z;
        Mon, 23 May 2022 21:32:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220523213246eusmtrp1656cb1c58caf277860cef71122195812~x2WUhYoEU2000220002eusmtrp1v;
        Mon, 23 May 2022 21:32:46 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-81-628bfd7fd378
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 97.BA.09522.E7DFB826; Mon, 23
        May 2022 22:32:46 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220523213246eusmtip2f1d7ac0017236a3f681beefedc2e6a09~x2WT-q8Yq1690516905eusmtip24;
        Mon, 23 May 2022 21:32:45 +0000 (GMT)
Message-ID: <bf7eec57-6ad6-2c1a-ea61-0e1d06fc77f5@samsung.com>
Date:   Mon, 23 May 2022 23:32:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [V4] serial: core: Do stop_rx in suspend path for console if
 console_suspend is disabled
Content-Language: en-US
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, dianders@chromium.org, mka@chromium.org,
        swboyd@chromium.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <1652692810-31148-1-git-send-email-quic_vnivarth@quicinc.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djPc7r1f7uTDN5NYLU4u+wgm0Xz4vVs
        Fu/mylhc3jWHzeLM4l52i88bHjNaLL60ks3i66XJzBbH7zxlcuD0mN1wkcVj06pONo/9c9ew
        e0zcU+fxeZNcAGsUl01Kak5mWWqRvl0CV8a9lxsYC06JVLyal9nAeEWgi5GTQ0LARKLr303m
        LkYuDiGBFYwSHWunsUM4XxglLp1dxALhfGaUmLtlBhNMy5rms1AtyxklFp1/CFX1kVFi9sUj
        7CBVvAJ2Eg13nwJ1cHCwCKhKLNpfDBEWlDg58wkLiC0qkCTx5s1VZhBbWCBd4snCbWALmAXE
        JW49mc8EMlNEYCXQgqt/WCASsRIdj16ygthsAoYSXW+72EBsTgEvifkT5rFD1MhLbH87B+w6
        CYE3HBKzep+yQ5ztIrHg5EdGCFtY4tXxLVBxGYnTk3tYQA6VEMiX+DvDGCJcIXHt9RpmCNta
        4s65X2wgJcwCmhLrd+lDhB0lPp3rZITo5JO48VYQ4gI+iUnbpjNDhHklOtqEIKrVJGYdXwe3
        8+CFS8wTGJVmIQXKLCTPz0LyyyyEvQsYWVYxiqeWFuempxYb56WW6xUn5haX5qXrJefnbmIE
        pqPT/45/3cG44tVHvUOMTByMhxglOJiVRHi3J3YkCfGmJFZWpRblxxeV5qQWH2KU5mBREudN
        ztyQKCSQnliSmp2aWpBaBJNl4uCUamDiqVAUeXQj7MylTAYvuZoljryHCq/MOa8Uq3CE1yDo
        2sSit4KLbb9dbPrT07rmzs8Ubq4sx8WJZ3d7by70C/Xw4WtlNz76+tasx4znOHdmXvf1r2o5
        z7vKpOlr6VmrC0nG5rb5gv/nvrjLEdQgUvyg+lODU5fwtE0/6qUWWHmxcdR6XVzoYX9gv5nR
        jOttp5LtqkV7eJ56Tcs9IJOoKPbCebfgsbeZy9z9A6YLcN9y1qh6E66/UyCdYcLGk5M33ylU
        LYuMT517pLlgmtLCVsFl+579CyjN39/ls8XlmLp9j8/tMz/rBBLaP6/43qmf/H7SPRW5myfE
        ozqK9yxVWbJNaOH0SXs4N7+/X+Tuel6JpTgj0VCLuag4EQCMUX4ntgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xe7p1f7uTDB4tULQ4u+wgm0Xz4vVs
        Fu/mylhc3jWHzeLM4l52i88bHjNaLL60ks3i66XJzBbH7zxlcuD0mN1wkcVj06pONo/9c9ew
        e0zcU+fxeZNcAGuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5m
        WWqRvl2CXsa9lxsYC06JVLyal9nAeEWgi5GTQ0LARGJN81nmLkYuDiGBpYwSV9ZuZYZIyEic
        nNbACmELS/y51sUGUfSeUeLsu9XsIAleATuJhrtPmboYOThYBFQlFu0vhggLSpyc+YQFJCwq
        kCRx5DA/SFhYIF3iycJtTCA2s4C4xK0n85lARooIrGSUmLrpGDNEIlbi1cFnLCC2kICnxM5F
        a9lAbDYBQ4mut11gNqeAl8T8CfPYIerNJLq2djFC2PIS29/OYZ7AKDQLyRmzkOybhaRlFpKW
        BYwsqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQIjcNuxn5t3MM579VHvECMTB+MhRgkOZiUR
        3u2JHUlCvCmJlVWpRfnxRaU5qcWHGE2BQTGRWUo0OR+YAvJK4g3NDEwNTcwsDUwtzYyVxHk9
        CzoShQTSE0tSs1NTC1KLYPqYODilGpgUTA22b3XbfG/RpdhO4fkT3ggwHWYXtRIyPljw0vai
        07xX/jsM8kQu3bQ2Mt5ru/pbeOsDcRMvkY/MWxPLl15dtkYo8F4Ju+O5yk7Hde0bvIIW6zuf
        5q+VaOO90TIl9oeVzkKORYd4N7HO+j0vokHafMLkRMvZfyJ1ajUK+++/OrWKc/WylGsnuV/P
        W/U83MZ7iVZ4rsqxVXwC7g+D7na4yph2fNnbuM3z6q9p1SqMTZN3Tjrbs32NnLnI/7ZK9zeC
        601iLa5PnPKsWML7yI+nMmr1vLq5N+1//+JKuxV1sLavZxfbI3MFK7YQ0/yLjhEu9g7/j5/m
        VJm5obXgbuv0669/pW06N/P+e/GML/uVWIozEg21mIuKEwFzKO0QSQMAAA==
X-CMS-MailID: 20220523213246eucas1p2d0da08d931a996cd3410eda1c2fd48c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220523213246eucas1p2d0da08d931a996cd3410eda1c2fd48c0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220523213246eucas1p2d0da08d931a996cd3410eda1c2fd48c0
References: <1652692810-31148-1-git-send-email-quic_vnivarth@quicinc.com>
        <CGME20220523213246eucas1p2d0da08d931a996cd3410eda1c2fd48c0@eucas1p2.samsung.com>
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16.05.2022 11:20, Vijaya Krishna Nivarthi wrote:
> For the case of console_suspend disabled, if back to back suspend/resume
> test is executed, at the end of test, sometimes console would appear to
> be frozen not responding to input. This would happen because, during
> resume, rx transactions can come in before system is ready, malfunction
> of rx happens in turn resulting in console appearing to be stuck.
>
> Do a stop_rx in suspend sequence to prevent this.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
> v4: moved the change to serial core to apply for all drivers
> v3: swapped the order of conditions to be more human readable
> v2: restricted patch to contain only stop_rx in suspend sequence
> v1: intial patch contained 2 additional unrelated changes in vicinity
> ---

This patch landed recently in linux-next as commit c9d2325cdb92 
("serial: core: Do stop_rx in suspend path for console if 
console_suspend is disabled").

Unfortunately it breaks console operation on my test systems after 
system suspend/resume cycle if 'no_console_suspend' kernel parameter is 
present. System properly resumes from suspend, the console displays all 
the messages and even command line prompt, but then doesn't react on any 
input. If I remove the 'no_console_suspend' parameter, the console is 
again operational after system suspend/resume cycle. Before this patch 
it worked fine regardless the 'no_console_suspend' parameter.

If this matters, the test system is ARM 32bit Samsung Exynos5422-based 
Odroid XU3lite board.

>   drivers/tty/serial/serial_core.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 82a1770..9a85b41 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2211,9 +2211,16 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
>   	}
>   	put_device(tty_dev);
>   
> -	/* Nothing to do if the console is not suspending */
> -	if (!console_suspend_enabled && uart_console(uport))
> +	/*
> +	 * Nothing to do if the console is not suspending
> +	 * except stop_rx to prevent any asynchronous data
> +	 * over RX line. Re-start_rx, when required, is
> +	 * done by set_termios in resume sequence
> +	 */
> +	if (!console_suspend_enabled && uart_console(uport)) {
> +		uport->ops->stop_rx(uport);
>   		goto unlock;
> +	}
>   
>   	uport->suspended = 1;
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

