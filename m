Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CB8486CE1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244806AbiAFVyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:54:10 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:56833 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244769AbiAFVyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:54:08 -0500
Received: from pop-os.home ([90.11.185.88])
        by smtp.orange.fr with ESMTPA
        id 5ahyntWWQ2lVY5ahznSlfQ; Thu, 06 Jan 2022 22:54:07 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 06 Jan 2022 22:54:07 +0100
X-ME-IP: 90.11.185.88
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 10/16] scsi: message: fusion: Remove usage of the deprecated "pci-dma-compat.h" API
Date:   Thu,  6 Jan 2022 22:54:05 +0100
Message-Id: <e38e897fbd3314718315b0e357c824e3f01775d6.1641500561.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In [1], Christoph Hellwig has proposed to remove the wrappers in
include/linux/pci-dma-compat.h.

Some reasons why this API should be removed have been given by Julia
Lawall in [2].

A coccinelle script has been used to perform the needed transformation.
It can be found in [3].


In this patch, all functions but pci_alloc_consistent() are handled.
pci_alloc_consistent() needs more attention and explanation.


[1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
[2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/
[3]: https://lore.kernel.org/kernel-janitors/20200716192821.321233-1-christophe.jaillet@wanadoo.fr/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/message/fusion/mptbase.c | 94 +++++++++++++++++---------------
 drivers/message/fusion/mptctl.c  | 51 ++++++++++-------
 drivers/message/fusion/mptlan.c  | 90 ++++++++++++++++--------------
 drivers/message/fusion/mptsas.c  | 51 ++++++++---------
 4 files changed, 154 insertions(+), 132 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 24a4532053e4..5a3b7b56e85a 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -316,8 +316,8 @@ mpt_is_discovery_complete(MPT_ADAPTER *ioc)
 		rc = 1;
 
  out_free_consistent:
-	pci_free_consistent(ioc->pcidev, hdr.ExtPageLength * 4,
-	    buffer, dma_handle);
+	dma_free_coherent(&ioc->pcidev->dev, hdr.ExtPageLength * 4, buffer,
+			  dma_handle);
  out:
 	return rc;
 }
@@ -1661,16 +1661,14 @@ mpt_mapresources(MPT_ADAPTER *ioc)
 		const uint64_t required_mask = dma_get_required_mask
 		    (&pdev->dev);
 		if (required_mask > DMA_BIT_MASK(32)
-			&& !pci_set_dma_mask(pdev, DMA_BIT_MASK(64))
-			&& !pci_set_consistent_dma_mask(pdev,
-						 DMA_BIT_MASK(64))) {
+			&& !dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))
+			&& !dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64))) {
 			ioc->dma_mask = DMA_BIT_MASK(64);
 			dinitprintk(ioc, printk(MYIOC_s_INFO_FMT
 				": 64 BIT PCI BUS DMA ADDRESSING SUPPORTED\n",
 				ioc->name));
-		} else if (!pci_set_dma_mask(pdev, DMA_BIT_MASK(32))
-			&& !pci_set_consistent_dma_mask(pdev,
-						DMA_BIT_MASK(32))) {
+		} else if (!dma_set_mask(&pdev->dev, DMA_BIT_MASK(32))
+			   && !dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32))) {
 			ioc->dma_mask = DMA_BIT_MASK(32);
 			dinitprintk(ioc, printk(MYIOC_s_INFO_FMT
 				": 32 BIT PCI BUS DMA ADDRESSING SUPPORTED\n",
@@ -1681,9 +1679,8 @@ mpt_mapresources(MPT_ADAPTER *ioc)
 			goto out_pci_release_region;
 		}
 	} else {
-		if (!pci_set_dma_mask(pdev, DMA_BIT_MASK(32))
-			&& !pci_set_consistent_dma_mask(pdev,
-						DMA_BIT_MASK(32))) {
+		if (!dma_set_mask(&pdev->dev, DMA_BIT_MASK(32))
+			&& !dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32))) {
 			ioc->dma_mask = DMA_BIT_MASK(32);
 			dinitprintk(ioc, printk(MYIOC_s_INFO_FMT
 				": 32 BIT PCI BUS DMA ADDRESSING SUPPORTED\n",
@@ -2769,9 +2766,9 @@ mpt_adapter_disable(MPT_ADAPTER *ioc)
 
 	if (ioc->spi_data.pIocPg4 != NULL) {
 		sz = ioc->spi_data.IocPg4Sz;
-		pci_free_consistent(ioc->pcidev, sz,
-			ioc->spi_data.pIocPg4,
-			ioc->spi_data.IocPg4_dma);
+		dma_free_coherent(&ioc->pcidev->dev, sz,
+				  ioc->spi_data.pIocPg4,
+				  ioc->spi_data.IocPg4_dma);
 		ioc->spi_data.pIocPg4 = NULL;
 		ioc->alloc_total -= sz;
 	}
@@ -3548,7 +3545,8 @@ mpt_free_fw_memory(MPT_ADAPTER *ioc)
 	sz = ioc->facts.FWImageSize;
 	dinitprintk(ioc, printk(MYIOC_s_DEBUG_FMT "free_fw_memory: FW Image  @ %p[%p], sz=%d[%x] bytes\n",
 		 ioc->name, ioc->cached_fw, (void *)(ulong)ioc->cached_fw_dma, sz, sz));
-	pci_free_consistent(ioc->pcidev, sz, ioc->cached_fw, ioc->cached_fw_dma);
+	dma_free_coherent(&ioc->pcidev->dev, sz, ioc->cached_fw,
+			  ioc->cached_fw_dma);
 	ioc->alloc_total -= sz;
 	ioc->cached_fw = NULL;
 }
@@ -4447,9 +4445,8 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 		 */
 		if (ioc->pcidev->device == MPI_MANUFACTPAGE_DEVID_SAS1078 &&
 		    ioc->dma_mask > DMA_BIT_MASK(35)) {
-			if (!pci_set_dma_mask(ioc->pcidev, DMA_BIT_MASK(32))
-			    && !pci_set_consistent_dma_mask(ioc->pcidev,
-			    DMA_BIT_MASK(32))) {
+			if (!dma_set_mask(&ioc->pcidev->dev, DMA_BIT_MASK(32))
+			    && !dma_set_coherent_mask(&ioc->pcidev->dev, DMA_BIT_MASK(32))) {
 				dma_mask = DMA_BIT_MASK(35);
 				d36memprintk(ioc, printk(MYIOC_s_DEBUG_FMT
 				    "setting 35 bit addressing for "
@@ -4457,10 +4454,10 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 				    ioc->name));
 			} else {
 				/*Reseting DMA mask to 64 bit*/
-				pci_set_dma_mask(ioc->pcidev,
-					DMA_BIT_MASK(64));
-				pci_set_consistent_dma_mask(ioc->pcidev,
-					DMA_BIT_MASK(64));
+				dma_set_mask(&ioc->pcidev->dev,
+					     DMA_BIT_MASK(64));
+				dma_set_coherent_mask(&ioc->pcidev->dev,
+						      DMA_BIT_MASK(64));
 
 				printk(MYIOC_s_ERR_FMT
 				    "failed setting 35 bit addressing for "
@@ -4595,8 +4592,8 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 		alloc_dma += ioc->reply_sz;
 	}
 
-	if (dma_mask == DMA_BIT_MASK(35) && !pci_set_dma_mask(ioc->pcidev,
-	    ioc->dma_mask) && !pci_set_consistent_dma_mask(ioc->pcidev,
+	if (dma_mask == DMA_BIT_MASK(35) && !dma_set_mask(&ioc->pcidev->dev,
+	    ioc->dma_mask) && !dma_set_coherent_mask(&ioc->pcidev->dev,
 	    ioc->dma_mask))
 		d36memprintk(ioc, printk(MYIOC_s_DEBUG_FMT
 		    "restoring 64 bit addressing\n", ioc->name));
@@ -4620,8 +4617,8 @@ PrimeIocFifos(MPT_ADAPTER *ioc)
 		ioc->sense_buf_pool = NULL;
 	}
 
-	if (dma_mask == DMA_BIT_MASK(35) && !pci_set_dma_mask(ioc->pcidev,
-	    DMA_BIT_MASK(64)) && !pci_set_consistent_dma_mask(ioc->pcidev,
+	if (dma_mask == DMA_BIT_MASK(35) && !dma_set_mask(&ioc->pcidev->dev,
+	    DMA_BIT_MASK(64)) && !dma_set_coherent_mask(&ioc->pcidev->dev,
 	    DMA_BIT_MASK(64)))
 		d36memprintk(ioc, printk(MYIOC_s_DEBUG_FMT
 		    "restoring 64 bit addressing\n", ioc->name));
@@ -4982,7 +4979,8 @@ GetLanConfigPages(MPT_ADAPTER *ioc)
 
 			}
 
-			pci_free_consistent(ioc->pcidev, data_sz, (u8 *) ppage0_alloc, page0_dma);
+			dma_free_coherent(&ioc->pcidev->dev, data_sz,
+					  (u8 *)ppage0_alloc, page0_dma);
 
 			/* FIXME!
 			 *	Normalize endianness of structure data,
@@ -5026,7 +5024,8 @@ GetLanConfigPages(MPT_ADAPTER *ioc)
 			memcpy(&ioc->lan_cnfg_page1, ppage1_alloc, copy_sz);
 		}
 
-		pci_free_consistent(ioc->pcidev, data_sz, (u8 *) ppage1_alloc, page1_dma);
+		dma_free_coherent(&ioc->pcidev->dev, data_sz,
+				  (u8 *)ppage1_alloc, page1_dma);
 
 		/* FIXME!
 		 *	Normalize endianness of structure data,
@@ -5325,7 +5324,8 @@ GetIoUnitPage2(MPT_ADAPTER *ioc)
 		if ((rc = mpt_config(ioc, &cfg)) == 0)
 			ioc->biosVersion = le32_to_cpu(ppage_alloc->BiosVersion);
 
-		pci_free_consistent(ioc->pcidev, data_sz, (u8 *) ppage_alloc, page_dma);
+		dma_free_coherent(&ioc->pcidev->dev, data_sz,
+				  (u8 *)ppage_alloc, page_dma);
 	}
 
 	return rc;
@@ -5456,7 +5456,9 @@ mpt_GetScsiPortSettings(MPT_ADAPTER *ioc, int portnum)
 				}
 			}
 			if (pbuf) {
-				pci_free_consistent(ioc->pcidev, header.PageLength * 4, pbuf, buf_dma);
+				dma_free_coherent(&ioc->pcidev->dev,
+						  header.PageLength * 4, pbuf,
+						  buf_dma);
 			}
 		}
 	}
@@ -5543,7 +5545,9 @@ mpt_GetScsiPortSettings(MPT_ADAPTER *ioc, int portnum)
 				}
 			}
 
-			pci_free_consistent(ioc->pcidev, header.PageLength * 4, pbuf, buf_dma);
+			dma_free_coherent(&ioc->pcidev->dev,
+					  header.PageLength * 4, pbuf,
+					  buf_dma);
 		}
 	}
 
@@ -5707,8 +5711,8 @@ mpt_inactive_raid_volumes(MPT_ADAPTER *ioc, u8 channel, u8 id)
 
  out:
 	if (buffer)
-		pci_free_consistent(ioc->pcidev, hdr.PageLength * 4, buffer,
-		    dma_handle);
+		dma_free_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
+				  buffer, dma_handle);
 }
 
 /**
@@ -5776,8 +5780,8 @@ mpt_raid_phys_disk_pg0(MPT_ADAPTER *ioc, u8 phys_disk_num,
  out:
 
 	if (buffer)
-		pci_free_consistent(ioc->pcidev, hdr.PageLength * 4, buffer,
-		    dma_handle);
+		dma_free_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
+				  buffer, dma_handle);
 
 	return rc;
 }
@@ -5840,8 +5844,8 @@ mpt_raid_phys_disk_get_num_paths(MPT_ADAPTER *ioc, u8 phys_disk_num)
  out:
 
 	if (buffer)
-		pci_free_consistent(ioc->pcidev, hdr.PageLength * 4, buffer,
-		    dma_handle);
+		dma_free_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
+				  buffer, dma_handle);
 
 	return rc;
 }
@@ -5929,8 +5933,8 @@ mpt_raid_phys_disk_pg1(MPT_ADAPTER *ioc, u8 phys_disk_num,
  out:
 
 	if (buffer)
-		pci_free_consistent(ioc->pcidev, hdr.PageLength * 4, buffer,
-		    dma_handle);
+		dma_free_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
+				  buffer, dma_handle);
 
 	return rc;
 }
@@ -6011,7 +6015,7 @@ mpt_findImVolumes(MPT_ADAPTER *ioc)
 		    pIoc2->RaidVolume[i].VolumeID);
 
  out:
-	pci_free_consistent(ioc->pcidev, iocpage2sz, pIoc2, ioc2_dma);
+	dma_free_coherent(&ioc->pcidev->dev, iocpage2sz, pIoc2, ioc2_dma);
 
 	return rc;
 }
@@ -6070,7 +6074,7 @@ mpt_read_ioc_pg_3(MPT_ADAPTER *ioc)
 		}
 	}
 
-	pci_free_consistent(ioc->pcidev, iocpage3sz, pIoc3, ioc3_dma);
+	dma_free_coherent(&ioc->pcidev->dev, iocpage3sz, pIoc3, ioc3_dma);
 
 	return 0;
 }
@@ -6122,7 +6126,8 @@ mpt_read_ioc_pg_4(MPT_ADAPTER *ioc)
 		ioc->spi_data.IocPg4_dma = ioc4_dma;
 		ioc->spi_data.IocPg4Sz = iocpage4sz;
 	} else {
-		pci_free_consistent(ioc->pcidev, iocpage4sz, pIoc4, ioc4_dma);
+		dma_free_coherent(&ioc->pcidev->dev, iocpage4sz, pIoc4,
+				  ioc4_dma);
 		ioc->spi_data.pIocPg4 = NULL;
 		ioc->alloc_total -= iocpage4sz;
 	}
@@ -6210,7 +6215,7 @@ mpt_read_ioc_pg_1(MPT_ADAPTER *ioc)
 		}
 	}
 
-	pci_free_consistent(ioc->pcidev, iocpage1sz, pIoc1, ioc1_dma);
+	dma_free_coherent(&ioc->pcidev->dev, iocpage1sz, pIoc1, ioc1_dma);
 
 	return;
 }
@@ -6255,7 +6260,8 @@ mpt_get_manufacturing_pg_0(MPT_ADAPTER *ioc)
 out:
 
 	if (pbuf)
-		pci_free_consistent(ioc->pcidev, hdr.PageLength * 4, pbuf, buf_dma);
+		dma_free_coherent(&ioc->pcidev->dev, hdr.PageLength * 4, pbuf,
+				  buf_dma);
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
diff --git a/drivers/message/fusion/mptctl.c b/drivers/message/fusion/mptctl.c
index ae433c150b37..0f447179e3f5 100644
--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -1046,9 +1046,9 @@ kbuf_alloc_2_sgl(int bytes, u32 sgdir, int sge_offset, int *frags,
 		goto free_and_fail;
 
 	if (sgdir & 0x04000000)
-		dir = PCI_DMA_TODEVICE;
+		dir = DMA_TO_DEVICE;
 	else
-		dir = PCI_DMA_FROMDEVICE;
+		dir = DMA_FROM_DEVICE;
 
 	/* At start:
 	 *	sgl = sglbuf = point to beginning of sg buffer
@@ -1080,8 +1080,9 @@ kbuf_alloc_2_sgl(int bytes, u32 sgdir, int sge_offset, int *frags,
 
 			bytes_allocd += this_alloc;
 			sgl->FlagsLength = (0x10000000|sgdir|this_alloc);
-			dma_addr = pci_map_single(ioc->pcidev,
-				buflist[buflist_ent].kptr, this_alloc, dir);
+			dma_addr = dma_map_single(&ioc->pcidev->dev,
+						  buflist[buflist_ent].kptr,
+						  this_alloc, dir);
 			sgl->Address = dma_addr;
 
 			fragcnt++;
@@ -1140,9 +1141,11 @@ kbuf_alloc_2_sgl(int bytes, u32 sgdir, int sge_offset, int *frags,
 			kptr = buflist[i].kptr;
 			len = buflist[i].len;
 
-			pci_free_consistent(ioc->pcidev, len, kptr, dma_addr);
+			dma_free_coherent(&ioc->pcidev->dev, len, kptr,
+					  dma_addr);
 		}
-		pci_free_consistent(ioc->pcidev, MAX_SGL_BYTES, sglbuf, *sglbuf_dma);
+		dma_free_coherent(&ioc->pcidev->dev, MAX_SGL_BYTES, sglbuf,
+				  *sglbuf_dma);
 	}
 	kfree(buflist);
 	return NULL;
@@ -1162,9 +1165,9 @@ kfree_sgl(MptSge_t *sgl, dma_addr_t sgl_dma, struct buflist *buflist, MPT_ADAPTE
 	int		 n = 0;
 
 	if (sg->FlagsLength & 0x04000000)
-		dir = PCI_DMA_TODEVICE;
+		dir = DMA_TO_DEVICE;
 	else
-		dir = PCI_DMA_FROMDEVICE;
+		dir = DMA_FROM_DEVICE;
 
 	nib = (sg->FlagsLength & 0xF0000000) >> 28;
 	while (! (nib & 0x4)) { /* eob */
@@ -1179,8 +1182,10 @@ kfree_sgl(MptSge_t *sgl, dma_addr_t sgl_dma, struct buflist *buflist, MPT_ADAPTE
 			dma_addr = sg->Address;
 			kptr = bl->kptr;
 			len = bl->len;
-			pci_unmap_single(ioc->pcidev, dma_addr, len, dir);
-			pci_free_consistent(ioc->pcidev, len, kptr, dma_addr);
+			dma_unmap_single(&ioc->pcidev->dev, dma_addr, len,
+					 dir);
+			dma_free_coherent(&ioc->pcidev->dev, len, kptr,
+					  dma_addr);
 			n++;
 		}
 		sg++;
@@ -1197,12 +1202,12 @@ kfree_sgl(MptSge_t *sgl, dma_addr_t sgl_dma, struct buflist *buflist, MPT_ADAPTE
 		dma_addr = sg->Address;
 		kptr = bl->kptr;
 		len = bl->len;
-		pci_unmap_single(ioc->pcidev, dma_addr, len, dir);
-		pci_free_consistent(ioc->pcidev, len, kptr, dma_addr);
+		dma_unmap_single(&ioc->pcidev->dev, dma_addr, len, dir);
+		dma_free_coherent(&ioc->pcidev->dev, len, kptr, dma_addr);
 		n++;
 	}
 
-	pci_free_consistent(ioc->pcidev, MAX_SGL_BYTES, sgl, sgl_dma);
+	dma_free_coherent(&ioc->pcidev->dev, MAX_SGL_BYTES, sgl, sgl_dma);
 	kfree(buflist);
 	dctlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "-SG: Free'd 1 SGL buf + %d kbufs!\n",
 	    ioc->name, n));
@@ -2283,13 +2288,13 @@ mptctl_do_mpt_command (MPT_ADAPTER *ioc, struct mpt_ioctl_command karg, void __u
 	/* Free the allocated memory.
 	 */
 	if (bufOut.kptr != NULL) {
-		pci_free_consistent(ioc->pcidev,
-			bufOut.len, (void *) bufOut.kptr, dma_addr_out);
+		dma_free_coherent(&ioc->pcidev->dev, bufOut.len,
+				  (void *)bufOut.kptr, dma_addr_out);
 	}
 
 	if (bufIn.kptr != NULL) {
-		pci_free_consistent(ioc->pcidev,
-			bufIn.len, (void *) bufIn.kptr, dma_addr_in);
+		dma_free_coherent(&ioc->pcidev->dev, bufIn.len,
+				  (void *)bufIn.kptr, dma_addr_in);
 	}
 
 	/* mf is null if command issued successfully
@@ -2405,7 +2410,9 @@ mptctl_hp_hostinfo(MPT_ADAPTER *ioc, unsigned long arg, unsigned int data_size)
 							pdata->BoardTracerNumber, 24);
 					}
 				}
-				pci_free_consistent(ioc->pcidev, hdr.PageLength * 4, pbuf, buf_dma);
+				dma_free_coherent(&ioc->pcidev->dev,
+						  hdr.PageLength * 4, pbuf,
+						  buf_dma);
 				pbuf = NULL;
 			}
 		}
@@ -2519,7 +2526,7 @@ mptctl_hp_hostinfo(MPT_ADAPTER *ioc, unsigned long arg, unsigned int data_size)
 	SET_MGMT_MSG_CONTEXT(ioc->ioctl_cmds.msg_context, 0);
 
 	if (pbuf)
-		pci_free_consistent(ioc->pcidev, 4, pbuf, buf_dma);
+		dma_free_coherent(&ioc->pcidev->dev, 4, pbuf, buf_dma);
 
 	/* Copy the data from kernel memory to user memory
 	 */
@@ -2623,7 +2630,8 @@ mptctl_hp_targetinfo(MPT_ADAPTER *ioc, unsigned long arg)
 				karg.negotiated_speed = HP_DEV_SPEED_ASYNC;
 		}
 
-		pci_free_consistent(ioc->pcidev, data_sz, (u8 *) pg0_alloc, page_dma);
+		dma_free_coherent(&ioc->pcidev->dev, data_sz, (u8 *)pg0_alloc,
+				  page_dma);
 	}
 
 	/* Set defaults
@@ -2658,7 +2666,8 @@ mptctl_hp_targetinfo(MPT_ADAPTER *ioc, unsigned long arg)
 				karg.phase_errors = (u32) le16_to_cpu(pg3_alloc->PhaseErrorCount);
 				karg.parity_errors = (u32) le16_to_cpu(pg3_alloc->ParityErrorCount);
 			}
-			pci_free_consistent(ioc->pcidev, data_sz, (u8 *) pg3_alloc, page_dma);
+			dma_free_coherent(&ioc->pcidev->dev, data_sz,
+					  (u8 *)pg3_alloc, page_dma);
 		}
 	}
 	hd = shost_priv(ioc->sh);
diff --git a/drivers/message/fusion/mptlan.c b/drivers/message/fusion/mptlan.c
index 117fa4ebf6d7..ddf9b7a2f7c9 100644
--- a/drivers/message/fusion/mptlan.c
+++ b/drivers/message/fusion/mptlan.c
@@ -516,9 +516,9 @@ mpt_lan_close(struct net_device *dev)
 		if (priv->RcvCtl[i].skb != NULL) {
 /**/			dlprintk((KERN_INFO MYNAM "/lan_close: bucket %05x "
 /**/				  "is still out\n", i));
-			pci_unmap_single(mpt_dev->pcidev, priv->RcvCtl[i].dma,
-					 priv->RcvCtl[i].len,
-					 PCI_DMA_FROMDEVICE);
+			dma_unmap_single(&mpt_dev->pcidev->dev,
+					 priv->RcvCtl[i].dma,
+					 priv->RcvCtl[i].len, DMA_FROM_DEVICE);
 			dev_kfree_skb(priv->RcvCtl[i].skb);
 		}
 	}
@@ -528,9 +528,9 @@ mpt_lan_close(struct net_device *dev)
 
 	for (i = 0; i < priv->tx_max_out; i++) {
 		if (priv->SendCtl[i].skb != NULL) {
-			pci_unmap_single(mpt_dev->pcidev, priv->SendCtl[i].dma,
-					 priv->SendCtl[i].len,
-					 PCI_DMA_TODEVICE);
+			dma_unmap_single(&mpt_dev->pcidev->dev,
+					 priv->SendCtl[i].dma,
+					 priv->SendCtl[i].len, DMA_TO_DEVICE);
 			dev_kfree_skb(priv->SendCtl[i].skb);
 		}
 	}
@@ -582,8 +582,8 @@ mpt_lan_send_turbo(struct net_device *dev, u32 tmsg)
 			__func__, sent));
 
 	priv->SendCtl[ctx].skb = NULL;
-	pci_unmap_single(mpt_dev->pcidev, priv->SendCtl[ctx].dma,
-			 priv->SendCtl[ctx].len, PCI_DMA_TODEVICE);
+	dma_unmap_single(&mpt_dev->pcidev->dev, priv->SendCtl[ctx].dma,
+			 priv->SendCtl[ctx].len, DMA_TO_DEVICE);
 	dev_kfree_skb_irq(sent);
 
 	spin_lock_irqsave(&priv->txfidx_lock, flags);
@@ -648,8 +648,9 @@ mpt_lan_send_reply(struct net_device *dev, LANSendReply_t *pSendRep)
 				__func__, sent));
 
 		priv->SendCtl[ctx].skb = NULL;
-		pci_unmap_single(mpt_dev->pcidev, priv->SendCtl[ctx].dma,
-				 priv->SendCtl[ctx].len, PCI_DMA_TODEVICE);
+		dma_unmap_single(&mpt_dev->pcidev->dev,
+				 priv->SendCtl[ctx].dma,
+				 priv->SendCtl[ctx].len, DMA_TO_DEVICE);
 		dev_kfree_skb_irq(sent);
 
 		priv->mpt_txfidx[++priv->mpt_txfidx_tail] = ctx;
@@ -720,8 +721,8 @@ mpt_lan_sdu_send (struct sk_buff *skb, struct net_device *dev)
 	skb_reset_mac_header(skb);
 	skb_pull(skb, 12);
 
-        dma = pci_map_single(mpt_dev->pcidev, skb->data, skb->len,
-			     PCI_DMA_TODEVICE);
+	dma = dma_map_single(&mpt_dev->pcidev->dev, skb->data, skb->len,
+			     DMA_TO_DEVICE);
 
 	priv->SendCtl[ctx].skb = skb;
 	priv->SendCtl[ctx].dma = dma;
@@ -868,13 +869,17 @@ mpt_lan_receive_post_turbo(struct net_device *dev, u32 tmsg)
 			return -ENOMEM;
 		}
 
-		pci_dma_sync_single_for_cpu(mpt_dev->pcidev, priv->RcvCtl[ctx].dma,
-					    priv->RcvCtl[ctx].len, PCI_DMA_FROMDEVICE);
+		dma_sync_single_for_cpu(&mpt_dev->pcidev->dev,
+					priv->RcvCtl[ctx].dma,
+					priv->RcvCtl[ctx].len,
+					DMA_FROM_DEVICE);
 
 		skb_copy_from_linear_data(old_skb, skb_put(skb, len), len);
 
-		pci_dma_sync_single_for_device(mpt_dev->pcidev, priv->RcvCtl[ctx].dma,
-					       priv->RcvCtl[ctx].len, PCI_DMA_FROMDEVICE);
+		dma_sync_single_for_device(&mpt_dev->pcidev->dev,
+					   priv->RcvCtl[ctx].dma,
+					   priv->RcvCtl[ctx].len,
+					   DMA_FROM_DEVICE);
 		goto out;
 	}
 
@@ -882,8 +887,8 @@ mpt_lan_receive_post_turbo(struct net_device *dev, u32 tmsg)
 
 	priv->RcvCtl[ctx].skb = NULL;
 
-	pci_unmap_single(mpt_dev->pcidev, priv->RcvCtl[ctx].dma,
-			 priv->RcvCtl[ctx].len, PCI_DMA_FROMDEVICE);
+	dma_unmap_single(&mpt_dev->pcidev->dev, priv->RcvCtl[ctx].dma,
+			 priv->RcvCtl[ctx].len, DMA_FROM_DEVICE);
 
 out:
 	spin_lock_irqsave(&priv->rxfidx_lock, flags);
@@ -927,8 +932,8 @@ mpt_lan_receive_post_free(struct net_device *dev,
 //		dlprintk((KERN_INFO MYNAM "@rpr[2] TC + 3\n"));
 
 		priv->RcvCtl[ctx].skb = NULL;
-		pci_unmap_single(mpt_dev->pcidev, priv->RcvCtl[ctx].dma,
-				 priv->RcvCtl[ctx].len, PCI_DMA_FROMDEVICE);
+		dma_unmap_single(&mpt_dev->pcidev->dev, priv->RcvCtl[ctx].dma,
+				 priv->RcvCtl[ctx].len, DMA_FROM_DEVICE);
 		dev_kfree_skb_any(skb);
 
 		priv->mpt_rxfidx[++priv->mpt_rxfidx_tail] = ctx;
@@ -1028,16 +1033,16 @@ mpt_lan_receive_post_reply(struct net_device *dev,
 //					IOC_AND_NETDEV_NAMES_s_s(dev),
 //					i, l));
 
-			pci_dma_sync_single_for_cpu(mpt_dev->pcidev,
-						    priv->RcvCtl[ctx].dma,
-						    priv->RcvCtl[ctx].len,
-						    PCI_DMA_FROMDEVICE);
+			dma_sync_single_for_cpu(&mpt_dev->pcidev->dev,
+						priv->RcvCtl[ctx].dma,
+						priv->RcvCtl[ctx].len,
+						DMA_FROM_DEVICE);
 			skb_copy_from_linear_data(old_skb, skb_put(skb, l), l);
 
-			pci_dma_sync_single_for_device(mpt_dev->pcidev,
-						       priv->RcvCtl[ctx].dma,
-						       priv->RcvCtl[ctx].len,
-						       PCI_DMA_FROMDEVICE);
+			dma_sync_single_for_device(&mpt_dev->pcidev->dev,
+						   priv->RcvCtl[ctx].dma,
+						   priv->RcvCtl[ctx].len,
+						   DMA_FROM_DEVICE);
 
 			priv->mpt_rxfidx[++priv->mpt_rxfidx_tail] = ctx;
 			szrem -= l;
@@ -1056,17 +1061,17 @@ mpt_lan_receive_post_reply(struct net_device *dev,
 			return -ENOMEM;
 		}
 
-		pci_dma_sync_single_for_cpu(mpt_dev->pcidev,
-					    priv->RcvCtl[ctx].dma,
-					    priv->RcvCtl[ctx].len,
-					    PCI_DMA_FROMDEVICE);
+		dma_sync_single_for_cpu(&mpt_dev->pcidev->dev,
+					priv->RcvCtl[ctx].dma,
+					priv->RcvCtl[ctx].len,
+					DMA_FROM_DEVICE);
 
 		skb_copy_from_linear_data(old_skb, skb_put(skb, len), len);
 
-		pci_dma_sync_single_for_device(mpt_dev->pcidev,
-					       priv->RcvCtl[ctx].dma,
-					       priv->RcvCtl[ctx].len,
-					       PCI_DMA_FROMDEVICE);
+		dma_sync_single_for_device(&mpt_dev->pcidev->dev,
+					   priv->RcvCtl[ctx].dma,
+					   priv->RcvCtl[ctx].len,
+					   DMA_FROM_DEVICE);
 
 		spin_lock_irqsave(&priv->rxfidx_lock, flags);
 		priv->mpt_rxfidx[++priv->mpt_rxfidx_tail] = ctx;
@@ -1077,8 +1082,8 @@ mpt_lan_receive_post_reply(struct net_device *dev,
 
 		priv->RcvCtl[ctx].skb = NULL;
 
-		pci_unmap_single(mpt_dev->pcidev, priv->RcvCtl[ctx].dma,
-				 priv->RcvCtl[ctx].len, PCI_DMA_FROMDEVICE);
+		dma_unmap_single(&mpt_dev->pcidev->dev, priv->RcvCtl[ctx].dma,
+				 priv->RcvCtl[ctx].len, DMA_FROM_DEVICE);
 		priv->RcvCtl[ctx].dma = 0;
 
 		priv->mpt_rxfidx[++priv->mpt_rxfidx_tail] = ctx;
@@ -1199,10 +1204,10 @@ mpt_lan_post_receive_buckets(struct mpt_lan_priv *priv)
 
 			skb = priv->RcvCtl[ctx].skb;
 			if (skb && (priv->RcvCtl[ctx].len != len)) {
-				pci_unmap_single(mpt_dev->pcidev,
+				dma_unmap_single(&mpt_dev->pcidev->dev,
 						 priv->RcvCtl[ctx].dma,
 						 priv->RcvCtl[ctx].len,
-						 PCI_DMA_FROMDEVICE);
+						 DMA_FROM_DEVICE);
 				dev_kfree_skb(priv->RcvCtl[ctx].skb);
 				skb = priv->RcvCtl[ctx].skb = NULL;
 			}
@@ -1218,8 +1223,9 @@ mpt_lan_post_receive_buckets(struct mpt_lan_priv *priv)
 					break;
 				}
 
-				dma = pci_map_single(mpt_dev->pcidev, skb->data,
-						     len, PCI_DMA_FROMDEVICE);
+				dma = dma_map_single(&mpt_dev->pcidev->dev,
+						     skb->data, len,
+						     DMA_FROM_DEVICE);
 
 				priv->RcvCtl[ctx].skb = skb;
 				priv->RcvCtl[ctx].dma = dma;
diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index 091b45024d34..0363b2a2264d 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -769,8 +769,8 @@ mptsas_add_device_component_starget_ir(MPT_ADAPTER *ioc,
 
  out:
 	if (buffer)
-		pci_free_consistent(ioc->pcidev, hdr.PageLength * 4, buffer,
-		    dma_handle);
+		dma_free_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
+				  buffer, dma_handle);
 }
 
 /**
@@ -1426,8 +1426,8 @@ mptsas_sas_enclosure_pg0(MPT_ADAPTER *ioc, struct mptsas_enclosure *enclosure,
 	enclosure->sep_channel = buffer->SEPBus;
 
  out_free_consistent:
-	pci_free_consistent(ioc->pcidev, hdr.ExtPageLength * 4,
-			    buffer, dma_handle);
+	dma_free_coherent(&ioc->pcidev->dev, hdr.ExtPageLength * 4, buffer,
+			  dma_handle);
  out:
 	return error;
 }
@@ -2081,8 +2081,8 @@ static int mptsas_get_linkerrors(struct sas_phy *phy)
 		le32_to_cpu(buffer->PhyResetProblemCount);
 
  out_free_consistent:
-	pci_free_consistent(ioc->pcidev, hdr.ExtPageLength * 4,
-			    buffer, dma_handle);
+	dma_free_coherent(&ioc->pcidev->dev, hdr.ExtPageLength * 4, buffer,
+			  dma_handle);
 	return error;
 }
 
@@ -2301,7 +2301,7 @@ static void mptsas_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
 		       << MPI_SGE_FLAGS_SHIFT;
 
 	if (!dma_map_sg(&ioc->pcidev->dev, job->request_payload.sg_list,
-			1, PCI_DMA_BIDIRECTIONAL))
+			1, DMA_BIDIRECTIONAL))
 		goto put_mf;
 
 	flagsLength |= (sg_dma_len(job->request_payload.sg_list) - 4);
@@ -2318,7 +2318,7 @@ static void mptsas_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
 	flagsLength = flagsLength << MPI_SGE_FLAGS_SHIFT;
 
 	if (!dma_map_sg(&ioc->pcidev->dev, job->reply_payload.sg_list,
-			1, PCI_DMA_BIDIRECTIONAL))
+			1, DMA_BIDIRECTIONAL))
 		goto unmap_out;
 	flagsLength |= sg_dma_len(job->reply_payload.sg_list) + 4;
 	ioc->add_sge(psge, flagsLength,
@@ -2356,10 +2356,10 @@ static void mptsas_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
 
 unmap_in:
 	dma_unmap_sg(&ioc->pcidev->dev, job->reply_payload.sg_list, 1,
-			PCI_DMA_BIDIRECTIONAL);
+			DMA_BIDIRECTIONAL);
 unmap_out:
 	dma_unmap_sg(&ioc->pcidev->dev, job->request_payload.sg_list, 1,
-			PCI_DMA_BIDIRECTIONAL);
+			DMA_BIDIRECTIONAL);
 put_mf:
 	if (mf)
 		mpt_free_msg_frame(ioc, mf);
@@ -2452,8 +2452,8 @@ mptsas_sas_io_unit_pg0(MPT_ADAPTER *ioc, struct mptsas_portinfo *port_info)
 	}
 
  out_free_consistent:
-	pci_free_consistent(ioc->pcidev, hdr.ExtPageLength * 4,
-			    buffer, dma_handle);
+	dma_free_coherent(&ioc->pcidev->dev, hdr.ExtPageLength * 4, buffer,
+			  dma_handle);
  out:
 	return error;
 }
@@ -2509,8 +2509,8 @@ mptsas_sas_io_unit_pg1(MPT_ADAPTER *ioc)
 	    device_missing_delay & MPI_SAS_IOUNIT1_REPORT_MISSING_TIMEOUT_MASK;
 
  out_free_consistent:
-	pci_free_consistent(ioc->pcidev, hdr.ExtPageLength * 4,
-			    buffer, dma_handle);
+	dma_free_coherent(&ioc->pcidev->dev, hdr.ExtPageLength * 4, buffer,
+			  dma_handle);
  out:
 	return error;
 }
@@ -2573,8 +2573,8 @@ mptsas_sas_phy_pg0(MPT_ADAPTER *ioc, struct mptsas_phyinfo *phy_info,
 	phy_info->attached.handle = le16_to_cpu(buffer->AttachedDevHandle);
 
  out_free_consistent:
-	pci_free_consistent(ioc->pcidev, hdr.ExtPageLength * 4,
-			    buffer, dma_handle);
+	dma_free_coherent(&ioc->pcidev->dev, hdr.ExtPageLength * 4, buffer,
+			  dma_handle);
  out:
 	return error;
 }
@@ -2654,8 +2654,8 @@ mptsas_sas_device_pg0(MPT_ADAPTER *ioc, struct mptsas_devinfo *device_info,
 	device_info->flags = le16_to_cpu(buffer->Flags);
 
  out_free_consistent:
-	pci_free_consistent(ioc->pcidev, hdr.ExtPageLength * 4,
-			    buffer, dma_handle);
+	dma_free_coherent(&ioc->pcidev->dev, hdr.ExtPageLength * 4, buffer,
+			  dma_handle);
  out:
 	return error;
 }
@@ -2737,8 +2737,8 @@ mptsas_sas_expander_pg0(MPT_ADAPTER *ioc, struct mptsas_portinfo *port_info,
 	}
 
  out_free_consistent:
-	pci_free_consistent(ioc->pcidev, hdr.ExtPageLength * 4,
-			    buffer, dma_handle);
+	dma_free_coherent(&ioc->pcidev->dev, hdr.ExtPageLength * 4, buffer,
+			  dma_handle);
  out:
 	return error;
 }
@@ -2810,8 +2810,8 @@ mptsas_sas_expander_pg1(MPT_ADAPTER *ioc, struct mptsas_phyinfo *phy_info,
 	phy_info->attached.handle = le16_to_cpu(buffer->AttachedDevHandle);
 
  out_free_consistent:
-	pci_free_consistent(ioc->pcidev, hdr.ExtPageLength * 4,
-			    buffer, dma_handle);
+	dma_free_coherent(&ioc->pcidev->dev, hdr.ExtPageLength * 4, buffer,
+			  dma_handle);
  out:
 	return error;
 }
@@ -2987,7 +2987,8 @@ mptsas_exp_repmanufacture_info(MPT_ADAPTER *ioc,
 	}
 out_free:
 	if (data_out_dma)
-		pci_free_consistent(ioc->pcidev, sz, data_out, data_out_dma);
+		dma_free_coherent(&ioc->pcidev->dev, sz, data_out,
+				  data_out_dma);
 put_mf:
 	if (mf)
 		mpt_free_msg_frame(ioc, mf);
@@ -4318,8 +4319,8 @@ mptsas_adding_inactive_raid_components(MPT_ADAPTER *ioc, u8 channel, u8 id)
 
  out:
 	if (buffer)
-		pci_free_consistent(ioc->pcidev, hdr.PageLength * 4, buffer,
-		    dma_handle);
+		dma_free_coherent(&ioc->pcidev->dev, hdr.PageLength * 4,
+				  buffer, dma_handle);
 }
 /*
  * Work queue thread to handle SAS hotplug events
-- 
2.32.0

