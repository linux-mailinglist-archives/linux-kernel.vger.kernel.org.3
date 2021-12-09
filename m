Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35DB46EA5C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbhLIOy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbhLIOyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:54:18 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5547C061746;
        Thu,  9 Dec 2021 06:50:44 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id q17so4030779plr.11;
        Thu, 09 Dec 2021 06:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EV/Cl/bL92j4HW6sBCN23DMzQiHfbcqAse4UFlhA0Hw=;
        b=X9ZRBon2HXgYSjJVE+NR80PPSbI+tV6BQ6e309dti7lIudYywVarkXOeBLlknLdZyP
         ZVht5pVSEnzdGOeoIckWRtgpVlPJ2yhXo6e8zCpTRQBaDSVTePgx5sxME7naMw6zn+yZ
         Xm3s3mEVLforTfbvGjzcBV+O+T/roJGCG/kKfLK+rIcaTDZ4hFdJtr+bPGjfpCfFBS/D
         QYJoS72LuZerioSUWtgGaE4x6bhcVDK1475/eNv1xyDj8foekSpwc2wGAZIlTKeV8TUU
         SGuPsciJmR31UExjI0ax/y8GSx+4XXPYkiNTNHwfg3iICmCPzcWqvbvnsY5e+G9FQvib
         5VVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EV/Cl/bL92j4HW6sBCN23DMzQiHfbcqAse4UFlhA0Hw=;
        b=wcOhIH8uj/CBL73EAYgycDO8J+VJj9gpxGE4LSG7HmGSnYgDVbVZa57o/40CFIkBhR
         sJWjyizVGdQedwgUXlJdUXKDKIRk0p4DAx1bajoaulyd01LgAYtJk2IOBXwD4qxj9cs9
         rdtcVFIX5+G1z1gdVnYynHjPy40U0r4PNDvGAWWkgGiF+AL7y470PJX7TT+BEi7Ov6fp
         8cL1L/Sldv5EdzfGjbmPmHJ00vn5jg/pI/PgPt31TmoMgcKmM0gw6FRAQvnIg5sXGR70
         xCd/gBCfBnfwj8/R3kJL/TCsnBPJWoo9G6slV61eyc13SwGZIcB801sGVfj38pWIxV+t
         ogew==
X-Gm-Message-State: AOAM530Fy59TliIfk2trEGWBDO5yOL+wKIGfJzjRxqMZ1GivDOiiRU88
        SYgF1GAKImFZbzF8e9rXFM2tubEt7Qo=
X-Google-Smtp-Source: ABdhPJwmaAAlrS7xMiUaSe3nKKM8Gh3tybpQz0QjIf6t6MSHSEW3wC+TS8Agb5mXvwdGObnBC24mqQ==
X-Received: by 2002:a17:90b:4b83:: with SMTP id lr3mr16561802pjb.98.1639061444544;
        Thu, 09 Dec 2021 06:50:44 -0800 (PST)
Received: from [192.168.1.26] (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id k28sm5695294pgl.69.2021.12.09.06.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 06:50:44 -0800 (PST)
Message-ID: <1164349c-93a5-ebb8-94aa-dbe03957c40f@gmail.com>
Date:   Thu, 9 Dec 2021 06:50:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] scsi: lpfc: Use struct_group() to initialize struct
 lpfc_cgn_info
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        James Smart <james.smart@broadcom.com>
Cc:     Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20211208195957.1603092-1-keescook@chromium.org>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <20211208195957.1603092-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/2021 11:59 AM, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memset(), avoid intentionally writing across
> neighboring fields.
> 
> Add struct_group() to mark "stat" region of struct lpfc_cgn_info that
> should be initialized to zero, and refactor the "data" region memset()
> to wipe everything up to the cgn_stats region.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---


looks fine.

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james



