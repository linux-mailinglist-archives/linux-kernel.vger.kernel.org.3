Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4989C49A652
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 03:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3413177AbiAYAid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 19:38:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2368892AbiAYAAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:00:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643068825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HVEOi3JfLG07H4d80rMuAmt9ScZ2srvvDue0ndS/BKY=;
        b=UEBlveCPYKYCW95UTHz0kPgIawFYPCtfAHg+cedWLjYggs47rKMii1su8M12W/TlWaIv7y
        Rwrs1xM9+4xuimXsxUVP0FSBk40kJe1G5a9EaNXMLzccZrGAtBzjH8Rkm17CebCISjRgX1
        KDdYxGj3BZD1q/wsY+qgu6+vEdZZA88=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-U3MDzZnaMZ-IHjlhMiodGQ-1; Mon, 24 Jan 2022 19:00:23 -0500
X-MC-Unique: U3MDzZnaMZ-IHjlhMiodGQ-1
Received: by mail-oi1-f198.google.com with SMTP id s131-20020acac289000000b002c6a61fd43fso10034375oif.23
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 16:00:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVEOi3JfLG07H4d80rMuAmt9ScZ2srvvDue0ndS/BKY=;
        b=rb207SfU2GFBCYU2gLMB6yxdLOl0NMJ+sWZ1UdIw2m4hpkzKbjgZbuMi7DcyvdqmT4
         oJefOss9UFIBpxmKjaK5AUy0dHAzBFWtqONPinQQCVPRonoMs2d+7H2QVzuUccnwU9g2
         lIWthmC6jVHCV3pCQ2TNcrZeqj9nbHdF2j2HqKe1IPvQ/cHgsYvXHD4TaPoSvZbNOL9k
         tXVeoQdh1CwuG0+xLyXHjvZxkbcldNDPh2lXnQ/PTVJw41KyP4+IyBOdgoMlf3rb5nMt
         ZlnMUDiskHZ+qxdzeV5ppcl+9gaozHpO+H/CJttLzYW2gEazPQuonQssdTkuhnghKpuh
         0xkg==
X-Gm-Message-State: AOAM530P/xh3ekRTgtXakPfLc1UXOifJ3Ok3UWh5jwYkZ6VC6xdy2qxj
        NCegndIoVLWgA0aeQIEhy6rEtUe9YXvh1PqwxeHIXq9gZ4gCAgNvwpz4bWoSsOQ8g/rb6+UGL28
        9jPcMF+bPerrql059Whv7bwoo
X-Received: by 2002:a4a:d51a:: with SMTP id m26mr5125956oos.1.1643068822874;
        Mon, 24 Jan 2022 16:00:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNLHUrHkZ0VgdUS81Fer4PLBA/LSFqmOEBwroF1KbQGd41b07ynHntqxgpZ6oKP+0FbdIuog==
X-Received: by 2002:a4a:d51a:: with SMTP id m26mr5125950oos.1.1643068822654;
        Mon, 24 Jan 2022 16:00:22 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id x1sm452732oto.38.2022.01.24.16.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 16:00:22 -0800 (PST)
Date:   Mon, 24 Jan 2022 17:00:21 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v5.17-rc1
Message-ID: <20220124170021.011b6a0e.alex.williamson@redhat.com>
In-Reply-To: <20220123125737.2658758-1-geert@linux-m68k.org>
References: <20220123125737.2658758-1-geert@linux-m68k.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jan 2022 13:57:37 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Below is the list of build error/warning regressions/improvements in
> v5.17-rc1[1] compared to v5.16[2].
> 
> Summarized:
>   - build errors: +17/-2
>   - build warnings: +23/-25
> 
> Note that there may be false regressions, as some logs are incomplete.
> Still, they're build errors/warnings.
> 
> Happy fixing! ;-)
> 
> Thanks to the linux-next team for providing the build service.
> 
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/e783362eb54cd99b2cac8b3a9aeac942e6f6ac07/ (all 99 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/df0cc57e057f18e44dac8e6c18aba47ab53202f9/ (98 out of 99 configs)
> 
> 
> *** ERRORS ***
> 
> 17 error regressions:
...
>   + /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]:  => 324:9, 317:9
>   + /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error: implicit declaration of function 'ioport_map' [-Werror=implicit-function-declaration]:  => 317:11
>   + /kisskb/src/drivers/vfio/pci/vfio_pci_rdwr.c: error: implicit declaration of function 'ioport_unmap' [-Werror=implicit-function-declaration]:  => 338:15

Patch posted:

https://lore.kernel.org/all/164306582968.3758255.15192949639574660648.stgit@omen/

Sorry I forgot to list Geert in Reported-by, I've done that in the
local copy that I'll use for a pull request.  Thanks,

Alex

