Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AB449F366
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346327AbiA1GRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346317AbiA1GRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:17:21 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE70FC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 22:17:20 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r10so7750276edt.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 22:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c/CkclFENvNU9iJxmtfyZRvpKKJMHcuyFFvdF23dkus=;
        b=iztXq6G/En1JOcuqfxwuQmEkrxjeY7ud/8FaRAl+JRzteWH4DWbgMyinAXl6UUKoAa
         KhXlvR0Azbo/gEj4XGIR/qGK5sCwzS2Yaw2lMcN2I4Paf+osEG4xu4H3Ulz8erxSzwZR
         JzwqoXxTcl9BfZUDCrt300Bte+UMRi7cQJf+803Dvm3mQagBODamM4azgTpqFkt+YIVp
         sbbDJa44C23DRjBJ6sp57wUBPqjeOAP4bmupcSlBwYlsG8x0ws5sVxmNshnTjAOneyil
         o+pwyqowZgZY5gyJ+8pr+ST5u4CfavieEA05NKZ4pby0qRAXW8pWtqEcCtm8RHaoKqCT
         Il5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c/CkclFENvNU9iJxmtfyZRvpKKJMHcuyFFvdF23dkus=;
        b=nOiPWoqo6mLyzZsxsvrUMdLbc/7i4VHEs/GvV5VxcipbK9Vf95E4SefqZvPi516NAM
         gC5KjaiVPGN18ZpulGEyOjpuiJEbcRxNUN5HQmY2175YIWBWzp3WcNiFXmB+/e6oYBL6
         mMjnVh7iR5UFcEqCR7gxLY9Z+kCSY2FiONclQqYkn3AXel7bmppoeiBolXEBEGij/EYA
         zP1G0ueN6zDJBcVqDGk8ULfvDktZMEUM/rg2wQaK5wwSTW5yYiwU4ATTPhIF9Rd5FGFm
         jGqZpwdH6+aDcZp2q+PUUcrWefwhqIRZCso6y976x/rKl3TvlGw7WOm1ySa0icSyDORA
         ndxA==
X-Gm-Message-State: AOAM533PBjAhMgGTZUiJQ0vsXGgQ63io4EgVlBTLI9hayZZ3LAlw/S2C
        LsKI7Go6vSHVJrMRmXfB6dubM2Jo/NljRU8Pr++Fiw==
X-Google-Smtp-Source: ABdhPJximxN0cZ3CWdkmtsyoHacjX2ErQykMiikn16RMEAC6KRVTgwYOyVzCzo4dRU9f+G2tcWmtARMhvZQJD8dbAWg=
X-Received: by 2002:a05:6402:5241:: with SMTP id t1mr6658992edd.161.1643350639264;
 Thu, 27 Jan 2022 22:17:19 -0800 (PST)
MIME-Version: 1.0
References: <1643289172-165636-1-git-send-email-john.garry@huawei.com> <1643289172-165636-2-git-send-email-john.garry@huawei.com>
In-Reply-To: <1643289172-165636-2-git-send-email-john.garry@huawei.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Fri, 28 Jan 2022 07:17:08 +0100
Message-ID: <CAMGffE=wKvNe5yoGpYY=Gcs8P5CAvoaoZjXuzO71S4mCx5g60Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] scsi: pm8001: Fix warning for undescribed param in process_one_iomb()
To:     John Garry <john.garry@huawei.com>
Cc:     jinpu.wang@ionos.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, damien.lemoal@opensource.wdc.com,
        Ajish.Koshy@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Viswas.G@microchip.com,
        chenxiang66@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 2:18 PM John Garry <john.garry@huawei.com> wrote:
>
> make W=1 complains of an undescribed function pararm:
>
> drivers/scsi/pm8001/pm80xx_hwi.c:3938: warning: Function parameter or member 'circularQ' not described in 'process_one_iomb'
>
> Fix it.
>
> Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
Thx John!
Acked-by: Jack Wang <jinpu.wang@ionos.com>
> ---
>  drivers/scsi/pm8001/pm80xx_hwi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
> index bbf538fe15b3..ce38a2298e75 100644
> --- a/drivers/scsi/pm8001/pm80xx_hwi.c
> +++ b/drivers/scsi/pm8001/pm80xx_hwi.c
> @@ -3931,6 +3931,7 @@ static int ssp_coalesced_comp_resp(struct pm8001_hba_info *pm8001_ha,
>  /**
>   * process_one_iomb - process one outbound Queue memory block
>   * @pm8001_ha: our hba card information
> + * @circularQ: outbound circular queue
>   * @piomb: IO message buffer
>   */
>  static void process_one_iomb(struct pm8001_hba_info *pm8001_ha,
> --
> 2.26.2
>
